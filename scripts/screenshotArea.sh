scrot -za $(hacksaw -f '%x,%y,%w,%h') ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png -e 'xclip -selection clipboard -t image/png -i $f'
