function zurl
    set tmpfile (uuidgen).pdf
    set tmpfile /tmp/$tmpfile

    # Try to download the file
    curl -L --fail $argv[1] -o $tmpfile
    if test $status -ne 0
        # If it fails (like 401/403), open in the browser instead
        echo "Access denied or authentication required. Opening in browser..."
        open $argv[1]
    else
        # Otherwise, open it with Zathura
        zathura $tmpfile &
    end
end
