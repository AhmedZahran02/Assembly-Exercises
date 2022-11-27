ShowMessage MACRO MyMessage ;PRINT STRING
                MOV         AH,9H
                MOV         DX,offset MyMessage
                INT         21H
                ENDM        ShowMessage

.MODEL SMALL  
.data
    string db 30 dup('$')
    no     db 'not palindrome','$'
    yes    db 'palindrome','$'
.code
MAIN PROC FAR
            mov         ax,@data
            mov         ds,ax
            
            MOV         AH,0AH
            MOV         DX,OFFSET string
            INT         21H

            mov         si,offset string+2
            mov         cl,[si-1]
    myloop: 
            push        si
            inc         si
            loop        myloop
            
            mov         si,offset string+2
            mov         cl,[si-1]
    myloop2:
            pop         di
            mov         al,[si]
            mov         bl,[di]
            cmp         al,bl
            jnz         np
            inc         si
            loop        myloop2
            jmp         ys

    np:     ShowMessage no
            HLT
    ys:     ShowMessage yes

            HLT
MAIN ENDP
END MAIN
