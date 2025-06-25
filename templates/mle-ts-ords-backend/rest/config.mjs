import { ords } from '../mle-cli/ords.mjs';

export const environment = ords.environment({
  name: 'USER_ENV',
  imports: [{ import_name: 'user_list', module_name: 'USER_LIST' }]
});

export const users = ords.module({
  name: 'users',
  basePath: '/',
  published: true,
  itemsPerPage: 25
});

users.post({ pattern: 'create', env: environment }, async (req, resp) => {
  const { newUser } = await import('user_list');
  const id = await newUser(req.query_parameters.name);
  resp.status(201);
  resp.content_type('application/json');
  resp.json({ id });
});

users.get({ pattern: ':id', env: environment, itemsPerPage: 0 }, async (req, resp) => {
  const { getUser } = await import('user_list');
  const user = await getUser(parseInt(req.uri_parameters.id));
  if (!user) {
    resp.status(404);
    resp.json({ msg: "User not found" });
  } else {
    resp.status(200);
    resp.json(user);
  }
});

users.delete({ pattern: 'delete/:id', env: environment }, async (req, resp) => {
  const { deleteUser } = await import('user_list');
  const deleted = await deleteUser(parseInt(req.uri_parameters.id));
  resp.status(deleted > 0 ? 200 : 404);
  resp.json({ rowsDeleted: deleted });
});

users.put({ pattern: 'edit/:id', env: environment }, async (req, resp) => {
  const { updateUser } = await import('user_list');
  const updated = await updateUser(parseInt(req.uri_parameters.id), req.query_parameters.name);
  resp.status(updated > 0 ? 200 : 404);
  resp.json({ rowsUpdated: updated });
});