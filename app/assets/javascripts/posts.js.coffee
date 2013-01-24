$ ->
        $('.docPost').hover(
                ->
                        $(this).addClass('docPostHover')
                        $(this).find('i').css("background",$(this).css("background"));
                ->
                        $(this).removeClass('docPostHover')
                        $(this).find('i').css("background","white");
                )
        $('.docPost').click ->
                # using $(x)[0].click() invokes the vanilla JS click funtion which
                # is like clicking the <a> tag. Using the jquery click() function
                # invokes the objects click jquery event which must already be bound 
                $(this).find('.docIcon').find('a')[0].click()
                