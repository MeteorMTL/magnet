/*****************************************************************************/
/* Player: Event Handlers */
/*****************************************************************************/
Template.Player.events({
  "submit #reaction-form": function (event, template) {
    event.preventDefault();
    var userId = template.data._id;
    var teamId = Template.parentData(1)._id;
    var feedback = event.target.feedback;
    var chartName = event.target.select;
    var chart = Charts.find({name: chartName.value});
    if (feedback.value) {
      var existingReaction = Reactions.findOne({userId: userId, teamId: teamId, evaluator: Meteor.userId()});
      if (existingReaction) {
        Reactions.update({_id: existingReaction._id}, {$set: {feedback: feedback.value, chartId: chart._id}});
      } else {
        Reactions.insert({userId: userId, teamId: teamId, feedbackId: feedback._id, evaluator: Meteor.userId(), feedback: feedback.value});
      }
    }
    Session.set("target" + userId + teamId, false);
  },
  "click .cancel": function (event, template) {
    var userId = template.data._id;
    var teamId = Template.parentData(1)._id;
    Session.set("target" + userId + teamId, false);
  },
  "click #edit": function (event, template) {
    var userId = template.data._id;
    var teamId = Template.parentData(1)._id;
    Session.set("target" + userId + teamId, true);
  },
  "keypress input": function (event, template) {
    if (event.keyCode == 13) {
      var reaction = Reactions.findOne({});
      Reactions.update({_id: reaction._id}, {$set: {feedback: event.currentTarget.value}});
      var userId = template.data._id;
      var teamId = Template.parentData(1)._id;
      Session.set("target" + userId + teamId, false);
    }
  },
  "click #delete": function (event, template) {
    var reaction = Reactions.findOne({userId: template.data._id, teamId: Template.parentData(1)._id});
    Reactions.remove({_id: reaction._id});
  }
});

/*****************************************************************************/
/* Player: Helpers */
/*****************************************************************************/
Template.Player.helpers({
  photo: function () {
    userPhoto = Photos.findOne({userId: this._id});
    if (userPhoto) return userPhoto.data;
  },
  profile: function () {
    user = Meteor.users.findOne({_id: this._id});
    if (user && user.profile) {
      user.profile.email = user.emails ? user.emails[0].address : "";
    }
    return user.profile;
  },
  reacting: function () {
    Session.set('reacting', true);
  },
  editing: function () {
    return Session.get("target" + this._id + Template.parentData(1)._id);
  },
  feedback: function () {
    var userId = this._id;
    var teamId = Template.parentData(1)._id;
    var reaction = Reactions.findOne({userId: userId, teamId: teamId, evaluator: Meteor.userId()});
    if (reaction) {
      return reaction.feedback;
    }
    return null;
  },
  charts: function () {
    return Charts.find({});
  },
  inTeamCanFeedback: function () {
    var commitments = Commitments.find({userId: Meteor.userId()}).fetch();
    var userId = this._id;
    var teamId = Template.parentData(1)._id;
    if (commitments && (Meteor.userId() != userId)) {
      var currentUserTeamIds = _.pluck(commitments, "teamId");
      return _.contains(currentUserTeamIds, teamId);
    } else {
      return false;
    }
  }
});

/*****************************************************************************/
/* Player: Lifecycle Hooks */
/*****************************************************************************/
Template.Player.created = function () {
};

Template.Player.rendered = function () {
};

Template.Player.destroyed = function () {
};
