/*****************************************************************************/
/* Footer: Event Handlers */
/*****************************************************************************/
Template.Footer.events({
  'click .__alert': function(e, t) {
    msg="Live social teaming for in-person events: http://speedteam.ca. Find team mates, do micro-projects";
    AntiModals.alert({title: "About", message: msg});
  }
});

/*****************************************************************************/
/* Footer: Helpers */
/*****************************************************************************/
Template.Footer.helpers({
});

/*****************************************************************************/
/* Footer: Lifecycle Hooks */
/*****************************************************************************/
Template.Footer.created = function () {
};

Template.Footer.rendered = function () {
};

Template.Footer.destroyed = function () {
};
