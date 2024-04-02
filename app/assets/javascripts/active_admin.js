
//= require arctic_admin/base

  document.addEventListener('DOMContentLoaded', function() {
        var propTypeField = document.querySelector('#property_prop_type');
        var flatDetailsFields = document.querySelector('#flat_details_fields');

        function toggleFlatDetailsFields() {
          if (propTypeField.value === 'FLAT') {
            flatDetailsFields.style.display = '';
          } else {
            flatDetailsFields.style.display = 'none';
          }
        }

        propTypeField.addEventListener('change', toggleFlatDetailsFields);
        toggleFlatDetailsFields();
      });