# Typescript NodeJS Package Template for AWS Lambda

Welcome to our Typescript NodeJS Package template designed for creating and deploying TypeScript-based Node packages on AWS Lambda. This template aims to streamline the development process and provide a consistent structure for AWS Lambda deployments.

## Key Features

- **Ease of Use**: Simplifies the process of setting up and structuring new TypeScript-based Node packages on AWS Lambda.
- **Standardization**: Provides a consistent structure for package development, ensuring best practices.
- **AWS Lambda Packaging Script**: Includes a Bash script `./packager.sh` that facilitates the creation of a deployable zip file for AWS Lambda.

## Steps to Publish Your Package

To smoothly transition your package from development to publication, follow these steps:

1. **Clone the Code**: Clone the Git repository and customize the package details in `package.json` as per your project requirements.

2. **TypeScript Code**: Develop your TypeScript code within the `./src` directory, with `index.ts` serving as the main entry point.

3. **Test Code**: Write tests for your code in `./src/*.spec.ts`.

4. **Package Code**: Once your code is ready, use the provided packaging script.

## Scripts

The following script commands can be executed using `npm` or `yarn`:

- **build**: Transpiles the TypeScript project to JavaScript. You can modify the configuration in `tsconfig.json` if needed.
- **start**: Executes the built JavaScript code by running `./{ts config build directory (default: dist)}/index.js`.
- **dev**: Runs the TypeScript code directly by executing `./src/index.ts`.
- **test**: Executes Jest tests.
- **format**: Applies Prettier formatting to the code in `./src`.
- **package:yarn**: Packages the code for AWS Lambda into `./deployable/lambda.zip` using `yarn` as the package manager.
- **package:npm**: Packages the code for AWS Lambda into `./deployable/lambda.zip` using `npm` as the package manager.

## Contributing

Contributions to enhance this template are welcome. Whether it's improving the workflow, adding new features, or refining documentation, your input is valuable.

For contributions or feedback, please open an issue or a pull request in this GitHub repository.

## License

This template is open-sourced under the MIT License. See the [LICENSE.md](/LICENSE.md) file for more details.