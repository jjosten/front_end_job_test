BootstrapModal=
  template:
    '<div class="modal fade" style="position:fixed">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          </div>
          <div class="modal-body"></div>
          <div class="modal-footer"></div>
        </div>
      </div>
    </div>'

  initialize: ->
    $(".modal").remove()
    $('#modal').html BootstrapModal.template

  content: (content) -> $('.modal .modal-body').html content

  title: (title) -> $('.modal .modal-dialog button').after "<h4 class='modal-title'>#{title}</h4>"

  show: ->  $('.modal').modal('show')

  hide: ->  $('.modal').modal 'hide'

window.BootstrapModal = BootstrapModal
