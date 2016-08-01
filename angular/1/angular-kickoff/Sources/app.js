import angular from 'angular';
import uiRouter from 'angular-ui-router';
import start from './Start/Start';

angular.module('kickoff', [
  uiRouter,
  start
]).config(
  ($urlRouterProvider) => {
    $urlRouterProvider.otherwise('/');
  }
);
