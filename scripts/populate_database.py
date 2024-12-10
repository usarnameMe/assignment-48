import os
import json
import django

from recipes.recipes_app.models import Recipe

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "recipes.settings")
print("DJANGO_SETTINGS_MODULE:", os.getenv("DJANGO_SETTINGS_MODULE"))
django.setup()
print("Django setup completed.")


def run():
    file = os.path.join(os.path.dirname(__file__), "mock_data.json")
    with open(file, 'r') as mock_data:
        data = json.load(mock_data)['data']
        for recipe in data:
            Recipe.objects.create(**recipe)
