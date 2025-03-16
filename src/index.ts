import express, { Request, Response } from "express";

const app = express();

app.get("/", (req: Request, res: Response) => {
  res.send("Express with docker and TS 🔥");
});

app.get("/error", (req: Request, res: Response) => {
  process.exit(1);
});

app.listen(4000, () => {
  console.log(`Server is running on port ${4000}`);
});
