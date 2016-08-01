class StartController {
  constructor($window) {
    this.$window = $window;
  }
  $onInit() {
    this.sayHi();
  }
  sayHi() {
    this.$window.console.log('Welcome to angular-kickoff!');
  }
}

StartController.$inject = ['$window'];
export default StartController;
