import { defineConfig } from "eslint/config";
import js from "@eslint/js";
import globals from "globals";

export default defineConfig([
  {
    ignores: [
      "dist/**",
      "node_modules/**"
    ]
  },

  {
    files: [
      "src/js/**/*.js"
    ],

    plugins: {
      js
    },

    extends: [
      "js/recommended"
    ],

    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "script",

      globals: {
        ...globals.browser,
        apex: "readonly"
      }
    }
  }
]);
