this.getUsedPoints = function () {
// count the number of Votes by this user
  if (Meteor.user()) {
    var usedPoints = 0;
    var votes = Votes.find({userId: Meteor.user()._id}).fetch();
    if (votes.length) {
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
