import angular from 'angular';
import chai from 'chai';
import sinon from 'sinon';
import sinonChai from 'sinon-chai';
import chaiAsPromised from 'chai-as-promised';
import Start from './Start';

chai.use(sinonChai);
chai.use(chaiAsPromised);

describe('Start Module', function() {

  beforeEach(angular.mock.module(Start));
  beforeEach(angular.mock.module(function($provide) {
    $provide.value('$window', { console: { log: sinon.spy() }});
  }));

  describe('Start Routing Testing', function() {
    let scope;

    beforeEach(angular.mock.inject(function($rootScope, $compile) {
      scope = $rootScope.$new();
      $compile(angular.element('<start></start>'))(scope);
      scope.$apply();
    }));

    it('Should have start state defined', angular.mock.inject(function ($state) {
      chai.expect($state.get('start')).to.exist;
    }));

    it('Should state route have "/" assigned', angular.mock.inject(function($state) {
      chai.expect($state.get('start').url).to.equal('/');
    }));
  });

  describe('Start Module Testing', function() {
    let elem;
    let scope;

    beforeEach(angular.mock.inject(function($rootScope, $compile) {
      scope = $rootScope.$new();
      elem = $compile(angular.element('<start></start>'))(scope);
      scope.$apply();
    }));

    it('Should had been called $window.console.log at least once', angular.mock.inject(function($window) {
      chai.expect($window.console.log.called);
    }));
  });
});
