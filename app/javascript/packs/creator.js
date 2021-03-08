var interestCreator = [];
var conceptCreator = [];



function updateInterestCreator(id, operation) {
    if (operation == "add" && interestCreator.length < 3) {
        interestCreator.push(id);
    } else if (operation == "add" && interestCreator.length == 3) {
        console.log("Maxx");
        alert('You can select Max 3 Interests.');
        $('#exampleFormControlSelect1 :selected').each(function(i, selected) {
            $("#exampleFormControlSelect1 option").prop("selected", false);
        });
    } else if (operation == "delete") {
        const index = interestCreator.indexOf(id);
        if (index > -1) {
            interestCreator.splice(index, 1);
        }
    }
    console.log(interestCreator);
}


function updateConceptCreator(id, operation) {
    if (operation == "add" && conceptCreator.length < 3) {
        conceptCreator.push(id);
    } else if (operation == "add" && conceptCreator.length == 3) {
        console.log("Maxx");
        alert('You can select Max 3 Concepts.');
        $('#exampleFormControlSelect2 :selected').each(function(i, selected) {
            $("#exampleFormControlSelect2 option").prop("selected", false);
        });
    } else if (operation == "delete") {
        const index = conceptCreator.indexOf(id);
        if (index > -1) {
            conceptCreator.splice(index, 1);
        }
    }
    console.log(conceptCreator);
}




$(document).ready(function() {


    $(document).on('click', '.addInterest', function() {
        var val = $(".new_interest").val();
        $(".new_interest").val('');

        $.ajax({
            type: "POST",
            url: "http://localhost:3000/newinterest",
            data: {
                "keyword": val
            },
            success: function(data) {
                console.log(data.resp);
                if (data.resp == "failed") {
                    alert('Interest Exists, Check drop down');
                } else {
                    updateInterestCreator(data.resp, "add");
                    $('.selectInterest').append('<option value="' + data.resp + '" selected>' + val + '</option>');

                    $('.selectedInterest').append(' ' + val);
                }
            }
        });





    });

    $(document).on('click', '.addConcept', function() {
        var val = $(".new_concept").val();
        $(".new_concept").val('');
        $.ajax({
            type: "POST",
            url: "http://localhost:3000/insertConcept",
            data: {
                "keyword": val
            },
            success: function(data) {
                console.log(data.resp);
                if (data.resp == "failed") {
                    alert('Concept Exists, Check drop down');
                } else {
                    updateConceptCreator(data.resp, "add");
                    $('.selectConcept').append('<option value="' + data.resp + '" selected>' + val + '</option>');
                    $('.selectedConcepts').append(' ' + val);
                }
            }
        });


    });


    $(".selectInterest")
        .change(function() {
            var str = "";
            interestCreator = [];
            console.log($("#exampleFormControlSelect1").length);
            if (interestCreator.length >= 3) {
                alert('You can select Max 3 Interests.');
            } else {
                $(".selectInterest option:selected").each(function() {
                    str = $(this).attr("value");

                    updateInterestCreator(str, "add");



                });
            }

        })
        .change();



    $(".selectConcept")
        .change(function() {
            var str = "";
            conceptCreator = [];
            console.log(conceptCreator.length);
            if (conceptCreator.length >= 3) {
                alert('You can select Max 3 Concepts.');
            } else {
                $(".selectConcept option:selected").each(function() {
                    str = $(this).attr("value");
                    updateConceptCreator(str, "add");
                });
            }

        })
        .change();

});