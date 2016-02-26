properties = (control, class_remove, class_add) ->
  {
    id: control.attr 'id'
    name: control.attr 'name'
    class: control.attr('class').replace(class_remove, class_add)
  }

states_length = "<%= @states.length %>"
state_input_id = "<%= @state_input_id %>" || "_state"
control = $("select[id$=#{state_input_id}], input[id$=#{state_input_id}]")
if states_length > 0
  options = "<%=j options_for_select(@states) %>"
  if control.prop('tagName') == 'INPUT'
    control.replaceWith $('<select>', properties(control, 'string', 'select')).append(options)
  else
    control.empty().append options
else
  control.replaceWith $('<input>', properties(control, 'select', 'string')) if control.prop('tagName') == 'SELECT'