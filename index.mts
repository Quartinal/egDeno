import { Application, Router } from "https://deno.land/x/oak@v13.2.5/mod.ts";

const app = new Application();
const router = new Router();

// JSON API
interface Item {
    characterN: number;
    character: string;
    class: string;
}

const characters: Item[] = [
    { characterN: 1, character: "sheep", class: "animals" },
    { characterN: 2, character: "cow", class: "animals" }
]

router.get("/items/:characterN", (context) => {
    const characterN = context.params.characterN;
  
    const character = characters.find(
      (character) => character.characterN.toString() === String(parseInt(characterN, 10))
    );
  
    if (character) {
      context.response.body = { character };
      context.response.type = "application/json";
    } else {
      context.response.status = 404;
      context.response.body = { error: `Character with ID ${characterN} not found` };
      context.response.type = "application/json";
    }
});  

app.use(router.routes());
app.use(router.allowedMethods());

await app.listen({ port: 8000 });
console.log("%c App is running on port 8000", "background-color: pink;");