nmap <leader>la :call ledger#transaction_date_set(line('.'), 'auxiliary')<cr>
nmap <leader>ld :call ledger#transaction_date_set(line('.'), 'primary')<cr>
nmap <leader>le :call ledger#entry()<cr>
let g:ale_completion_enabled = 0
let g:ledger_date_format = '%Y-%m-%d'
