$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data("content-tabs"));
  this.$activeLink = this.$contentTabs.children(".active");
  this.$el.on("click", this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function(event) {
  event.preventDefault();
  var activeTab = this.$contentTabs.find('.active');
  activeTab.addClass('transitioning').removeClass('active');
  activeTab.one("transitionend", this.activateTab.bind(this));
  this.$activeLink.removeClass('active');
  this.$activeLink = $(event.target);
  this.$activeLink.addClass('active');
};

$.Tabs.prototype.activateTab = function(event) {
  $('.transitioning').removeClass('transitioning');
  var activeTab = this.$contentTabs.find(this.$activeLink.data('target'));
  this.$activeLink = this.$contentTabs.children(".active");
  setTimeout(function() {
    activeTab.addClass('active').addClass('transitioning');
    activeTab.removeClass('transitioning');
  }, 0);
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
