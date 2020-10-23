var interest = [];


$(document).ready(function() {

    function errorAlert() {
        $('.interestWarning').show();
    }


    $(document).mouseup(function(e) {
        var container = $(".searchDropdown");
        if (!container.is(e.target) && container.has(e.target).length === 0) {
            container.hide();
        }
    });

    function sendPost(urlX, paramX) {
        $.ajax({
            type: "POST",
            url: urlX,
            data: {
                "keyword": paramX
            },
            success: function(data) {

                $('.searchDropdown').show();
                $('.list-group').html('');

                for (i = 0; i < data.length; i++) {
                    // console.log(data[i]);
                    $('.list-group').append('<li class="list-group-item list-group-item-action" style="cursor:pointer;" id="' + data[i].id + '">' + data[i].interest_name + '</li>');
                }
                if (paramX != "") {
                    $('.list-group').append('<li class="list-group-item list-group-item-action" style="cursor:pointer;" id="NoVal">' + paramX + '</li>');
                }
            }
        });
    }


    function sendPost2(urlX, paramX, paramY) {
        $.ajax({
            type: "POST",
            url: urlX,
            data: {
                "val1": paramX,
                "val2": paramY
            },
            success: function(data) {

                $('.searchDropdown').show();
                $('.list-group').html('');

                for (i = 0; i < data.length; i++) {
                    // console.log(data[i]);
                    $('.list-group').append('<li class="list-group-item list-group-item-action" style="cursor:pointer;" id="' + data[i].id + '">' + data[i].interest_name + '</li>');
                }
                if (paramX != "") {
                    $('.list-group').append('<li class="list-group-item list-group-item-action" style="cursor:pointer;" id="NoVal">' + paramX + '</li>');
                }
            }
        });
    }


    function updateInterest(id, operation) {
        if (operation == "add" && interest.length < 5) {
            interest.push(id);
        } else if (operation == "add" && interest.length == 5) {
            errorAlert();
            console.log("Maxx");
        } else if (operation == "delete") {
            const index = interest.indexOf(id);
            if (index > -1) {
                interest.splice(index, 1);
            }
        }
        console.log(interest);
    }


    // Selecting Interest from the dropdown

    $(document).on('click', '.IntrButton', function() {
        var id = $(this).attr("id");
        var valSet = $(this).attr("valSet");
        if (valSet == "false" && interest.length < 5) {
            $(".Intr" + id).attr("valSet", "true");
            $(".Intr" + id).attr("class", "btn btn-primary mb-1 IntrButton Intr" + id);
            updateInterest(id, "add");
        } else {
            $(".Intr" + id).attr("valSet", "false");
            $(".Intr" + id).attr("class", "btn btn-outline-primary mb-1 IntrButton Intr" + id);
            updateInterest(id, "delete");
        }
    });



    // This will add new Interest to backend

    $(document).on('click', '.list-group-item', function() {
        var id = $(this).attr("id");
        $('.searchDropdown').hide();

        if (interest.length == 5) {
            errorAlert();
        } else if (id != "NoVal" && interest.length < 5) {
            if ($(".Intr" + id).length != 0) {
                $(".Intr" + id).attr("class", "btn btn-primary mb-1");
                updateInterest(id, "add");
            }
        } else {
            var newIntr = $(this).html();

            $('.interest-buttons').append('<a class="btn btn-primary mb-1 mr-1" id="NoVal"> ' + newIntr + '</a>');
            updateInterest("999", "add");

        }

    });

    $('.modal').modal('show');

    $("#inputUsername").on('keyup', function(e) {
        var val = $(this).val();
        sendPost("http://localhost:3000/interest", val);

        // if (e.key === 'Enter' || e.keyCode === 13) {
        //     $('searchDropdown').hide();
        // }
    });

    $("#InterestModal").on("hidden.bs.modal", function() {
        console.log("Updating Interest");
        var val = 1;
        var val1 = 2;

        sendPost("http://localhost:3000/clearinterest", val);

        for (i = 0; i < interest.length; i++) {
            sendPost2("http://localhost:3000/insertinterest", val, interest[i]);
        }

    });
});