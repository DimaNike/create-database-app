import { newUser } from '../../src/index.ts'

export async function POST(req, resp) {
  const id = await newUser(req.query_parameters.name);
  resp.status(201);
  resp.content_type('application/json');
  resp.json({ id });
}


