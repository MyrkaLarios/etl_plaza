$(document).on('turbolinks:load', function () {
  if ($('#etl-start').length > 0) {
    $('#etl-start').on('click', function () {
      $('.etl-info').addClass('d-none');
      $('.extract-info').removeClass('d-none');
    });
  }

  if ($('#load-data').length > 0) {
    $('#load-data').on('click', function () {
      $('#load-data-div').addClass('d-none');
      $('#loading').removeClass('d-none');
    });
  }
});
