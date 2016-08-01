import angular from 'angular';
import uiRouter from 'angular-ui-router';
import StartComponent from './start.component';

const start = angular
  .module('Start', [uiRouter])
  .component('start', StartComponent)
  .config(($stateProvider) => {
    $stateProvider
      .state('start', {
        url: '/',
        template: '<start></start>'
      });
  })
  .name;

export default start;
