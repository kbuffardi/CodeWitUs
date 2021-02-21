$(document).ready(function() {




    $("#emailInput").keyup(function(event) {
        var input = $(this).val();
        console.log(input);

        $.ajax({
            type: "POST",
            url: "http://localhost:3000/userList",
            data: {
                "keyword": input
            },
            success: function(data) {
                $("#userTable").html(" ");

                for (var i = 0; i < data.length; i++) {
                    var obj = data[i];
                    $("#userTable").append('<tr><th scope="row">' + obj.id + '</th><td>' + obj.username + '</td><td> ' + obj.email +
                        '</td><td><select id="' + obj.id + '" class="mySelect form-select"aria-label="Default select example"><option class="selectButton"id="' + obj.id + '"value="0">Student</option><option class="selectButton"id="' + obj.id + '"value="1">Creator</option><option class="selectButton"id="' + obj.id + '"value="2">Admin</option></select></td></tr>');



                }
            }
        });
        return false;
    });


});


$(document).on('change', '.mySelect', function() {

    var value = $(this).attr('id');
    var priv = $('#' + value).val();
    $.ajax({
        type: "POST",
        url: "http://localhost:3000/updateRole",
        data: {
            "uid": value,
            "role": priv
        },
        success: function(data) {}
    });
});