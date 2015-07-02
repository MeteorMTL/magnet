this.getUsedPoints = function () {
  var user = Meteor.user();
  if (user) {
    var usedPoints;
    var votes = Votes.find({userId: user._id}).fetch();
    if (!votes.length) usedPoints = 0;
    else {
      usedPoints = _.reduce(_.map(
        votes,
        function (vote) {
          return vote.points;
        }),
        function (sum, points) {
          return sum + points;
        });
    }
    return usedPoints;
  }
};

this.getAvailablePoints = function () {
  return 20 - getUsedPoints();
};
