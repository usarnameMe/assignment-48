# Recipe App

Foobar is a Python library for dealing with word pluralization.

## Build and Run Project


Docker is required to run the project

Fof building

```bash
make build
```

to run the project

```bash
make run
```

## Usage

The Recipe App provides an API for managing recipes. Below are examples of how you can interact with the API:

### Example Endpoints

- **Get All Recipes**:  
  `GET /api/recipes/`  
  Returns a list of all available recipes.

- **Retrieve a Recipe**:  
  `GET /api/recipes/<id>/`  
  Retrieves details of a specific recipe by its ID.

- **Create a Recipe**:  
  `POST /api/recipes/`  
  Requires a JSON payload with recipe details. Example:
  ```json
  {
      "title": "Chocolate Cake",
      "ingredients": "Flour, Sugar, Cocoa Powder, Eggs",
      "instructions": "Mix ingredients and bake for 30 minutes."
  }

