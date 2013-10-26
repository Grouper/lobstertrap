###*
 * LobsterTrap adds an automatic shortcuts reference modal to MouseTrap
 *
 *
 *                                       ,.---.
 *                             ,,,,     /    _ `.
 *                              \\\\   /      \  )
 *                               |||| /\/``-.__\/
 *                               ::::/\/_
 *               {{`-.__.-'(`(^^(^^^(^ 9 `.========='
 *              {{{{{{ { ( ( (  (   (-----:=
 *               {{.-'~~'-.(,(,,(,,,(__6_.'=========.
 *                               ::::\/\
 *                               |||| \/\  ,-'/\
 *                              ////   \ `` _/  )
 *                             ''''     \  `   /
 *                                       `---''
 *
 *
###
class LobsterTrap

  constructor: ->
    @shortcuts = []
    @view = new LobsterTrapView
      lobster: this

    # Set up the first shortcut
    @bind '?', "Show this menu", @view.toggleModal

  bind: (key, description, fn) =>
    @shortcuts.push [key, description]
    Mousetrap.bind(key, fn)

  reset: =>
    Mousetrap.reset()
    @constructor()


class LobsterTrapView extends Backbone.View
  bodyHTML: =>
    """
      <div id='lobster-modal' class='modal'>
        <div class='modal-header'>
          <h3> Keyboard Shortcuts
            <button class='close' type='button' data-dismiss='modal'>
              &times
            </button>
          </h3>
        </div>
        <div class='modal-body'>
        </div>
      </div>
    """
  shortcutHTML: (key, description)=>
    """
      <div class='row'>
        <div class='span2 row'>
          <code> #{key} </code>
        </div>
        <div class='span3 description'>
          #{description}
        </div>
      </div>
    """

  events:
    'click .close' : 'hide'

  initialize: ->
    Mousetrap.bind 'esc', @hide

    @$el.appendTo($('body')).addClass('lobster-modal-container').hide().css
      width: window.innerWidth
      height: window.innerHeight
      position: 'fixed'
      top: 0
      left: 0
      'z-index': 10000

    @render()

    # Hide the view if we click on the X or if we click outside the modal
    @$el.on 'click', @hide
    @$('#lobster-modal').on 'click', (e) =>
      e.stopPropagation()
    @$('.close').on 'click', @hide

  render: =>
    $(@el).html(@bodyHTML())
    @update()

  update: =>
    @$('.modal-body').empty()
    for shortcutPair in @options.lobster.shortcuts
      html = @shortcutHTML(shortcutPair[0], shortcutPair[1])
      @$('.modal-body').append(html)

    return this

  toggleModal: =>
    @update()
    @$el.toggle()

  hide: =>
    @$el.hide()

$ ->
  window.lobster = new LobsterTrap