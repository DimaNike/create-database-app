// mle-cli/ords.js
export const ords = (() => {
  const envs = [];
  const modules = [];
  const toPLSQL = {
    env: (e) => `create or replace MLE ENV ${e.name} imports (
${e.imports.map(i => `    '${i.import_name}' module ${i.module_name}`).join(',\n')}
);
`,
    module: (m) => `declare
    c_module_name constant varchar2(255) := '${m.name}';
begin
    ords.define_module(
        p_module_name    => c_module_name,
        p_base_path      => '${m.basePath}',
        p_status         => '${m.published ? 'PUBLISHED' : 'UNPUBLISHED'}',
        p_items_per_page => ${m.itemsPerPage ?? 25}
    );
end;
/`,
    route: (mod, r) => {
      let handlerSrc = r.handler.toString().trim();
      handlerSrc = handlerSrc.replace(/^async\s+/, '');
      return `declare
    c_module_name constant varchar2(255) := '${mod.name}';
    c_pattern     constant varchar2(255) := '${r.pattern}';
begin
    ords.define_template(
        p_module_name => c_module_name,
        p_pattern     => c_pattern
    );

    ords.define_handler(
        p_module_name    => c_module_name,
        p_pattern        => c_pattern,
        p_method         => '${r.method}',
        p_source_type    => 'mle/javascript',
        p_mle_env_name   => '${r.env.name}',
        ${r.itemsPerPage !== undefined ? `p_items_per_page => ${r.itemsPerPage},` : ''}
        p_source         => q'~
${handlerSrc}
~'
    );
    commit;
end;
/`}
  };

  return {
    environment(e) {
      envs.push(e);
      return e;
    },
    module(config) {
      const m = {
        name: config.name,
        basePath: config.basePath || '/',
        published: config.published ?? true,
        itemsPerPage: config.itemsPerPage ?? 25,
        routes: [],        
        get(route, handler) {
          this.routes.push({ method: 'GET', ...route, handler });
        },
        post(route, handler) {
          this.routes.push({ method: 'POST', ...route, handler });
        },
        put(route, handler) {
          this.routes.push({ method: 'PUT', ...route, handler });
        },
        delete(route, handler) {
          this.routes.push({ method: 'DELETE', ...route, handler });
        }
      };
      modules.push(m);
      return m;
    },
    generatePLSQL() {
      const parts = [];

      for (const env of envs) parts.push(toPLSQL.env(env));
      parts.push(`begin\n  ords.enable_schema;\nend;\n/`);

      for (const mod of modules) {
        parts.push(toPLSQL.module(mod));
        for (const r of mod.routes) {
          parts.push(toPLSQL.route(mod, r));
        }
      }

      return parts.join('\n\n');
    }
  };
})();