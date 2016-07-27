var app = angular.module("alarmClock", [])
	.controller('MainController', ['$scope', '$interval', 
		function($scope, $interval) {
		
			// store time and update it every second, set variable to change if there is an alarm going off.
			$scope.currentTime = { time : new Date() };
			
			$scope.goneOff = false;
			
			var alarm = document.getElementById("alarm_audio");

			// play alarm sound
			function playAlarm() {
				alarm.play();
			}

			// stop alarm sound
			function pauseAlarm() {
				alarm.pause();
			}
		
			// update the time every second, also check if any of the any of the alarms have been passed. If so, set alert.
			$scope.getTime = function() {
			
				$scope.currentTime = { time : new Date() };
			
			}
			
			$interval( function(){
				$scope.getTime();
				angular.forEach($scope.alarms, function(alarm, index){
					if(alarm.time <= $scope.currentTime.time) {
						alarm.goneOff = true;
						$scope.goneOff = true;
						playAlarm();
						return;
					}
				});
			}, 1000 ); 
		
			// Store alarms
			$scope.alarms = [];

			// when user clicks "X" button, remove alarm object from array
			$scope.removeAlarm = function(index) {
				$scope.alarms.splice(index, 1);
				alarm.goneOff = false;
				$scope.goneOff = false;
				pauseAlarm();
			}
			
			// Input returns absolute datetime
			$scope.addAlarm = function() {
				$scope.alarms.push({time: $scope.alarmTime, goneOff: false});
				$scope.alarmTime = "";
			}
		
		}
	]);