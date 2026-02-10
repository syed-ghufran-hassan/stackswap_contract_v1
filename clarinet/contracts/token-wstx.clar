;; wrap the native STX token into an SRC20 compatible token to be usable along other tokens
(impl-trait .sip-010-trait-v1.sip-010-trait)

;; STSW_TOKEN ERRORS 4226~4229
(define-constant PERMISSION_DENIED_ERROR u4225)

(define-data-var deployer-principal principal tx-sender)

;; Map to track allowances: {owner, spender} -> amount
(define-map allowances 
    { owner: principal, spender: principal } 
    uint
)

;; get the token balance of owner
(define-read-only (get-balance (owner principal))
  (begin
    (ok (print (stx-get-balance owner)))
  )
)

(define-read-only (get-total-supply)
  (ok stx-liquid-supply)
)

;; returns the token name
(define-read-only (get-name)
  (ok "wrapped STX")
)

(define-read-only (get-symbol)
  (ok "STX")
)

;; the number of decimals used
(define-read-only (get-decimals)
  (ok u6)
)

;; Variable for URI storage
(define-data-var uri (string-utf8 256) u"https://app.stackswap.org/tokens/stx.json")

;; Public getter for the URI
(define-read-only (get-token-uri)
  (ok (some (var-get uri))))


;; Setter for the URI - only the owner can set it
(define-public (set-token-uri (updated-uri (string-utf8 256)))
  (begin
    (asserts! (is-eq tx-sender (var-get deployer-principal)) (err PERMISSION_DENIED_ERROR))
    ;; Print the action for any off chain watchers
    (print { action: "set-token-uri", updated-uri: updated-uri })
    (ok (var-set uri updated-uri))))


;; Transfers tokens to a recipient

(define-public (transfer (amount uint) (from principal) (to principal) (memo (optional (buff 34))))
  (begin
    (asserts! (is-eq from tx-sender) (err PERMISSION_DENIED_ERROR))
    (try! (stx-transfer? amount tx-sender to))
    (match memo to-print (print to-print) 0x)
    (ok true)
  )
)

;; Approve a spender to transfer up to a certain amount
(define-public (approve (spender principal) (amount uint))
  (begin
    ;; Allow any owner (tx-sender) to approve a spender
    (map-set allowances { owner: tx-sender, spender: spender } amount)
    (print { action: "approve", owner: tx-sender, spender: spender, amount: amount })
    (ok true)
  )
)

;; Transfer tokens from owner to recipient using allowance
(define-public (transfer-from (owner principal) (recipient principal) (amount uint))
  (let ((current-allowance (default-to u0 (map-get? allowances { owner: owner, spender: tx-sender }))))
    (begin
      (asserts! (>= current-allowance amount) (err PERMISSION_DENIED_ERROR))
      ;; Perform the STX transfer
      (try! (stx-transfer? amount owner recipient))
      ;; Reduce the allowance
      (map-set allowances { owner: owner, spender: tx-sender } (- current-allowance amount))
      (print { action: "transfer-from", spender: tx-sender, owner: owner, recipient: recipient, amount: amount })
      (ok true)
    )
  )
)

;; Increase a spender's allowance by a specified amount
(define-public (increase-allowance (spender principal) (added-amount uint))
  (let ((current-allowance (default-to u0 (map-get? allowances { owner: tx-sender, spender: spender }))))
    (begin
      (map-set allowances { owner: tx-sender, spender: spender } (+ current-allowance added-amount))
      (print { action: "increase-allowance", owner: tx-sender, spender: spender, added-amount: added-amount })
      (ok true)
    )
  )
)

;; Decrease a spender's allowance by a specified amount
(define-public (decrease-allowance (spender principal) (subtracted-amount uint))
  (let ((current-allowance (default-to u0 (map-get? allowances { owner: tx-sender, spender: spender }))))
    (begin
      (asserts! (>= current-allowance subtracted-amount) (err PERMISSION_DENIED_ERROR))
      (map-set allowances { owner: tx-sender, spender: spender } (- current-allowance subtracted-amount))
      (print { action: "decrease-allowance", owner: tx-sender, spender: spender, subtracted-amount: subtracted-amount })
      (ok true)
    )
  )
)
