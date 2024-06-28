export const recipesControllers = async (
  _req: any,
  res: { json: (arg0: string) => void }
) => {
  const response = "Lista de recetas";
  res.json(response);
};
