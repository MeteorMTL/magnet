/*****************************************************************************/
/* TopicEdit: Event Handlers */
/*****************************************************************************/
Template.TopicEdit.events({
  "submit #topicEditForm": function (event, Template) {
    Router.go("/")
  }
});

/*****************************************************************************/
/* TopicEdit: Helpers */
/*****************************************************************************/
Template.TopicEdit.helpers({
});

/*****************************************************************************/
/* TopicEdit: Lifecycle Hooks */
/*****************************************************************************/
Template.TopicEdit.created = function () {
};

Template.TopicEdit.rendered = function () {
};

Template.TopicEdit.destroyed = function () {
};
