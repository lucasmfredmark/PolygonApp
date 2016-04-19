$(function() {
    $('#searchUser').keyup(function() {
        var searchText = $('#searchUser').val();
        var results = 0;
        
        $('#usersTable tr').slice(2).each(function() {
            var fullName = $(this).find('td:nth-child(2)').text();
            var emailAddress = $(this).find('td:nth-child(3)').text();
            
            if (fullName.toLowerCase().indexOf(searchText.toLowerCase()) === -1 &&
                emailAddress.toLowerCase().indexOf(searchText.toLowerCase()) === -1) {
                $(this).hide();
            } else {
                $(this).show();
                results++;
            }
        });
        
        if (results === 0) {
            $('#usersTable tr:nth-child(2) td span').text(searchText);
            $('#usersTable tr:nth-child(2)').show();
        } else {
            $('#usersTable tr:nth-child(2)').hide();
        }
    });
    
    $('#searchBuilding').keyup(function() {
        var searchText = $('#searchBuilding').val();
        var results = 0;
        
        $('#buildingsTable tr').slice(2).each(function() {
            var address = $(this).find('td:nth-child(2)').text();
            var parcelNumber = $(this).find('td:nth-child(3)').text();
            
            if (address.toLowerCase().indexOf(searchText.toLowerCase()) === -1 &&
                parcelNumber.toLowerCase().indexOf(searchText.toLowerCase()) === -1) {
                $(this).hide();
            } else {
                $(this).show();
                results++;
            }
        });
        
        if (results === 0) {
            $('#buildingsTable tr:nth-child(2) td span').text(searchText);
            $('#buildingsTable tr:nth-child(2)').show();
        } else {
            $('#buildingsTable tr:nth-child(2)').hide();
        }
    });
    
    /*
    $('#searchReport').keyup(function() {
        var searchText = $('#searchReport').val();
        var results = 0;
        
        $('#reportsTable tr').slice(2).each(function() {
            //var address = $(this).find('td:nth-child(2)').text();
            //var parcelNumber = $(this).find('td:nth-child(3)').text();
            
            if (address.toLowerCase().indexOf(searchText.toLowerCase()) === -1 &&
                parcelNumber.toLowerCase().indexOf(searchText.toLowerCase()) === -1) {
                $(this).hide();
            } else {
                $(this).show();
                results++;
            }
        });
        
        if (results === 0) {
            $('#reportsTable tr:nth-child(2) td span').text(searchText);
            $('#reportsTable tr:nth-child(2)').show();
        } else {
            $('#reportsTable tr:nth-child(2)').hide();
        }
    });
    */
});