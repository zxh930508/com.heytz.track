var exec = require('cordova/exec');
exports.startTrack = function (AK, serviceID, entityName, success, error) {
  exec(success, error, "trackWrapper", "startTrack", [AK, serviceID, entityName]);
};
exports.stopTrack = function (success, error) {
  exec(success, error, "trackWrapper", "stopTrack", []);
};