###*
 * LobsterTrap adds an automatic shortcuts reference modal to MouseTrap
 *
 *
 *                             ,.---.
 *                   ,,,,     /    _ `.
 *                    \\\\   /      \  )
 *                     |||| /\/``-.__\/
 *                     ::::/\/_
 *     {{`-.__.-'(`(^^(^^^(^ 9 `.========='
 *    {{{{{{ { ( ( (  (   (-----:=
 *     {{.-'~~'-.(,(,,(,,,(__6_.'=========.
 *                     ::::\/\
 *                     |||| \/\  ,-'/\
 *                    ////   \ `` _/  )
 *                   ''''     \  `   /
 *                             `---''
 *
 *
###
class LobsterTrap

  constructor: ->
    @shortcuts = []
    @bind '?', "Show this menu", @toggleModal

    # Only ever render the view once, append it to body
    if !@view
      @view = new LobsterTrapView
        lobster: this

      @el = @view.render().$el
      $('body').append(@el)

      @view.$el.modal(
        show: false
      )

  bind: (key, description, fn) =>
    @shortcuts.push [key, description]
    Mousetrap.bind(key, fn)

  reset: =>
    Mousetrap.reset()
    @constructor()

  toggleModal: =>
    @view.render()
    @view.$el.modal('toggle')


class LobsterTrapView extends Backbone.View
  template: JST["backbone/templates/lobster_trap"]

  events:
    'click .close' : 'hide'

  initialize: ->

  render: =>
    params =
      shortcuts: @options.lobster.shortcuts
    $(@el).html(@template(params)).addClass('modal hide').attr('id', 'lobster-modal')

    return this

  hide: =>
    @$el.modal('hide')

window.lobster = new LobsterTrap