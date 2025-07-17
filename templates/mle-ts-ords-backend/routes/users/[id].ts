import { getUser, deleteUser, updateUser } from '../../src/index.ts'

export async function GET(req, resp) {
  const user = await getUser(parseInt(req.uri_parameters.id));
  if (!user) {
    resp.status(404);
    resp.json({ msg: "User not found" });
  } else {
    resp.status(200);
    resp.json(user);
  }
}

export async function DELETE(req, resp) {
  const deleted = await deleteUser(parseInt(req.uri_parameters.id));
  resp.status(deleted > 0 ? 200 : 404);
  resp.json({ rowsDeleted: deleted });
}

export async function PUT(req, resp) {
  const updated = await updateUser(parseInt(req.uri_parameters.id), req.query_parameters.name);
  resp.status(updated > 0 ? 200 : 404);
  resp.json({ rowsUpdated: updated });
}