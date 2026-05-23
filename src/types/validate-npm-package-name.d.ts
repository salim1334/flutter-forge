declare module 'validate-npm-package-name' {
  interface ValidateResult {
    validForNewPackages: boolean;
    errors?: string[];
    warnings?: string[];
  }
  function validate(name: string): ValidateResult;
  export default validate;
}
