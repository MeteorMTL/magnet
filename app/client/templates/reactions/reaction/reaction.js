/*****************************************************************************/
/* Reaction: Event Handlers */
/*****************************************************************************/
Template.Reaction.events({
});

/*****************************************************************************/
/* Reaction: Helpers */
/*****************************************************************************/
Template.Reaction.helpers({
  evaluatorName: function () {
    var reaction = Reactions.findOne({_id: this._id});
    var evaluator = Meteor.users.findOne({_id: reaction.evaluator});
    if (evaluator) {
      return evaluator.profile.name;
    } else {
      return "anonymous";
    }
  },
  teamName: function () {
    var reaction = Reactions.findOne({_id: this._id});
    var team = Teams.findOne({_id: reaction.teamId});
    if (team) {
      return team.name;
    } else {
      return "N/A";
    }
  }
});

/*****************************************************************************/
/* Reaction: Lifecycle Hooks */
/*****************************************************************************/
Template.Reaction.created = function () {
};

Template.Reaction.rendered = function () {
};

Template.Reaction.destroyed = function () {
};
