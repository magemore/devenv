function nsl
    echo 'select * from notes order by id desc limit 5;' | mysql -uroot -pq1234e twitter 2>/dev/null
end
