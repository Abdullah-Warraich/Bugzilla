// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require select2
//= require cocoon
$(document).on('turbolinks:load', function() {

  $('form').on('click', '.remove_record', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').hide();
    return event.preventDefault();
  });

  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });
  
});

$(document).ready(function() {
    // base_url = window.location.origin
    $('#bug_project_id').select2({
        minimumInputLength: 1,
        placeholder: 'Search',
        ajax: {
            url: '/projects/searchproject',
            type: 'get',
            dataType: 'json',
            quietMillis: 250,
            data: function(params) {
                console.log(params)
                var query = {
                  searchTerm: params.term,
                  type: 'public'
                }
                console.log(query)

      // Query parameters will be ?searchTerm=[term]&type=public
            return query;
                // return {                                       
                //     searchTerm: params.term,
                // };
            },
            processResults: function(data, params) {
              console.log(data) 
                return {            
              results: $.map(data, function(value, index){
              return {id: value.id, text: value.name};
            })
              }

            },
            cache: true,
        },
    });
});


$("#bug_type1").on("change", function() {
  var value = $(this).val()
  $("#bug_status option").hide() //hide all options from slect box
  //loop through values
  if (value == 'feature'){
    $("#bug_status option[value='new']").show()
    $("#bug_status option[value='started']").show()
    $("#bug_status option[value='completed']").show()
  }else{
    $("#bug_status option[value='new']").show()
    $("#bug_status option[value='started']").show()
    $("#bug_status option[value='resolved']").show()
  }
})