<script>
    console.log(
        '%c我是Alan,这里是我记录所见所思所想之地，欢迎与我交流,\n我的邮箱是 alan@1991421.cn',
        'color: #2a3778'
    );
    console.log('%c' +
        '             _     _                    _         ____              _        _    __        \n' +
        '     /\\     | |   | |                  | |       / __ \\            | |      (_)  / _|       \n' +
        '    /  \\    | |_  | |_    __ _    ___  | | __   | |  | |  _ __     | |       _  | |_    ___ \n' +
        '   / /\\ \\   | __| | __|  / _` |  / __| | |/ /   | |  | | | \'_ \\    | |      | | |  _|  / _ \\\n' +
        '  / ____ \\  | |_  | |_  | (_| | | (__  |   <    | |__| | | | | |   | |____  | | | |   |  __/\n' +
        ' /_/    \\_\\  \\__|  \\__|  \\__,_|  \\___| |_|\\_\\    \\____/  |_| |_|   |______| |_| |_|    \\___|', 'color: #2a3778;font-weight:bold');

    const postElements = document.getElementsByClassName('post-body');
    document.addEventListener('copy', (event) => {
        if (!(postElements.length > 0 && postElements[0].contains(event.target))) {
            return;
        }
        // const pageLink = `\n\nRead more at: ${document.location.href}`;
        // event.clipboardData.setData('text', document.getSelection() + pageLink);
        // event.preventDefault();
    });
</script>
