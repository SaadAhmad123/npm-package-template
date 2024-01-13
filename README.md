# Typescript NodeJS Package Template for AWS Lambda

Welcome to our Typescript NodeJS Package template designed for creating and deploying TypeScript-based Node packages on AWS Lambda. This template aims to streamline the development process and provide a consistent structure for AWS Lambda deployments.

## Key Features

- **Ease of Use**: Simplifies the process of setting up and structuring new TypeScript-based Node packages on AWS Lambda.
- **Standardization**: Provides a consistent structure for package development, ensuring best practices.
- **AWS Lambda Packaging Script**: Includes a Bash script `./packager.sh` that facilitates the creation of a deployable zip file for AWS Lambda.

## Steps to Deploy Your Package

Follow these steps for a seamless transition of your package from development to deployment:

1. **Clone the Code**: Clone the Git repository using the command:
   ```bash
   git clone --branch aws_lambda https://github.com/SaadAhmad123/npm-package-template.git
   ```
   Customize the package details in `package.json` according to your project requirements.

2. **TypeScript Code**: Develop your TypeScript code within the `./src` directory, with `index.ts` as the main entry point.

3. **Test Code**: Write tests for your code in `./src/*.spec.ts`.

4. **Package Code**: Use the provided packaging script (`packager.sh`). This script orchestrates the following steps:
   - Creates a temporary folder.
   - Copies the transpiled JavaScript code into the temporary folder.
   - Copies `package.json` and the lock file to the temporary folder.
   - Installs production dependencies in the temporary folder.
   - Zips the contents to the specified output directory (default: `deployable/lambda.zip`).

   Execute the script with the following command:
   ```bash
   bash packager.sh -p <package_manager> -d <directory> -t <temp_directory> -o <output_directory>
   ```
   Options:
   - `-p <package_manager>`: Specify the package manager (yarn | npm).
   - `-d <directory>`: Specify the directory where `.js` files exist.
   - `-t <temp_directory>`: Specify the temporary directory (default: `.temp`).
   - `-o <output_directory>`: Specify the output path (relative to the script's directory).
   - `-h`: Print this help message.

5. **Deploy Code**: The generated `.zip` file can be deployed to an AWS Lambda instance through various methods, including the AWS Management Console, Terraform, or other deployment tools.

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