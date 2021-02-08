function ajaxPost(urlX, paramX) {
    $.ajax({
        type: "POST",
        url: urlX,
        data: {
            "keyword": paramX
        },
        success: function(data) {

            console.log(data.resp);

            if (data.resp == "Deleted")
                $("#thumbId").attr('class', 'far fa-thumbs-up');
            else
                $("#thumbId").attr('class', 'fas fa-thumbs-up');


        }
    });
}

$(document).on('click', '.thumb', function() {
    var id = $(this).attr("id");
    ajaxPost("http://localhost:3000/like", id);

});