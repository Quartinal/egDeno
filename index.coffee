# WARNING: This file is dynamically typed and is meant to be
# meant to be more concise, and is designed for reading only

# It is not meant to be executed, as TypeScript 
# is better suited for that over CoffeeScript

{ Application, Router } = require("https://deno.land/x/oak@v13.2.5/mod.ts")

app = new Application()
router = new Router()

# JSON API
class Item
  constructor: (@characterN, @character, @class) ->

characters =
  [new Item(1, "sheep", "animals"),
  new Item(2, "cow", "animals"),
  new Item(3, "donkey", "animals"),
  new Item(4, "rabbit", "animals")]

router.get "/items/:characterN", (context) ->
  characterN = context.params.characterN

  character = characters.find (character) ->
    character.characterN.toString() is String(parseInt(characterN, 10))

  if character?
    context.response.body = { character }
    context.response.type = "application/json"
  else
    context.response.status = 404
    context.response.body = { error: "Character with ID #{characterN} not found" }
    context.response.type = "application/json"

app.use router.routes()
app.use router.allowedMethods()

app.listen { port: 8000 }, ->
  console.log "%c App is running on port 8000", "background-color: pink;"