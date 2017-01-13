EnableExplicit
UsePNGImageDecoder() 

Structure Player
  Name.s
  Image.i 
  Square.i
  Active.i
EndStructure
Global Dim Players.Player(4) 

Structure Square
  Offsetx.i
  Offsety.i 
EndStructure 
Global Dim Squares.Square(30)  
  
Players(0)\Name = ""
Players(0)\Square = 0
Players(0)\Active = #False
Players(1)\Name = ""
Players(1)\Square = 0
Players(1)\Active = #False
Players(2)\Name = ""
Players(2)\Square = 0
Players(2)\Active = #False
Players(3)\Name = ""
Players(3)\Square = 0
Players(3)\Active = #False

Global frmMain.i,GameBoard.i, Player1.i, Player2.i, Player3.i, Player4.i
Global imgBoard.i,imgPlayer1.i,imgPlayer2.i,imgPlayer3.i,imgPlayer4.i,ImgDie.i,btnNewGame.i,txtStatus.i,btnRollDie.i
Global DiceRolling.i,CurrentPlayer.i = 0
Global strP1Name.i,imgP1Disp.i,strP2Name.i,imgP2Disp.i,strP3Name.i,imgP3Disp.i,strP4Name.i,imgP4Disp.i
Global Die1.i,Die2.i,Die3.i,Die4.i,Die5.i,Die6.i
Global chkP1.i,chkP2.i,chkP3.i,chkP4.i
Global Playing.i = #True

;Load Images
GameBoard = LoadImage(#PB_Any,GetCurrentDirectory() + "Images\GameBoard.bmp")
Player1.i   = LoadImage(#PB_Any,GetCurrentDirectory() + "Images\Adore.png")
Player2.i   = LoadImage(#PB_Any,GetCurrentDirectory() + "Images\Cool.png")
Player3.i   = LoadImage(#PB_Any,GetCurrentDirectory() + "Images\Furious.png")
Player4.i   = LoadImage(#PB_Any,GetCurrentDirectory() + "Images\Pudently.png")
  
Die1 = LoadImage(#PB_Any, "Images\dice1.png")
Die2 = LoadImage(#PB_Any, "Images\dice2.png")
Die3 = LoadImage(#PB_Any, "Images\dice3.png")
Die4 = LoadImage(#PB_Any, "Images\dice4.png")
Die5 = LoadImage(#PB_Any, "Images\dice5.png")
Die6 = LoadImage(#PB_Any, "Images\dice6.png")

Define Event.i

Declare MovePlayer(Player.i)

Procedure CDMovePlayer(Player.i,x1.i,y1.i,x2.i,y2.i)
  
  Define Quit.i = #False
  Define xDone.i = #False
  Define yDone.i = #False
  Define Midx.i,Midy.i,Top.i,Left.i
  
  Select Player
    Case 0
      Midx = x1 + 5
      Midy = y1 + 5
       x2 = x2 + 5
      y2 = y2 + 5    
    Case 1
      Midx = x1 + 40
      Midy = y1 + 5
      x2 = x2 + 40
      y2 = y2 + 5     
    Case 2
      Midx = x1 + 5
      Midy = y1 + 40  
      x2 = x2 + 5
      y2 = y2 + 40     
    Case 3
      Midx = x1 + 40
      Midy = y1 + 40 
      x2 = x2 + 40
      y2 = y2 + 40
      
    Default
      Midx = x1
      Midy = y1
      
  EndSelect
  
  While quit = #False 
   
  If xDone = #False
    If x2 < x1
      Midx = Midx - 4
      If midx =< x2
        xDone = #True
      EndIf
    Else
      Midx = Midx + 4
      If midx => x2
        xDone = #True
      EndIf
    EndIf
  EndIf

  If yDone = #False
    If y2 < y1
      Midy = Midy - 4
      If Midy <= y2
        yDone = #True
      EndIf
    Else
      Midy = Midy + 4
      If Midy => y2
        yDone = #True
      EndIf
    EndIf
  EndIf

  StartDrawing(CanvasOutput(imgBoard))
  DrawingMode(#PB_2DDrawing_Transparent) 
  DrawImage(ImageID(GameBoard),0,0,GadgetWidth(imgBoard),GadgetHeight(imgBoard)) 
  
    Select Player
    Case 0
      ;Player 1
      DrawImage(ImageID(Player1),Midx,Midy,32,32)
      
      ;Player 2
      If Players(1)\Square > 0 And Players(1)\Active = #True
        Top = Squares(Players(1)\Square)\Offsety + 5
        Left = Squares(Players(1)\Square)\Offsetx + 40
        DrawImage(ImageID(Player2),Left,Top,32,32) 
      EndIf
      
      ;Player 3
      If Players(2)\Square > 0 And Players(2)\Active = #True
        Top = Squares(Players(2)\Square)\Offsety + 40
        Left = Squares(Players(2)\Square)\Offsetx + 5
        DrawImage(ImageID(Player3),Left,Top,32,32) 
      EndIf 
      
      ;Player 4
      If Players(3)\Square > 0 And Players(3)\Active = #True
        Top = Squares(Players(3)\Square)\Offsety + 40
        Left = Squares(Players(3)\Square)\Offsetx + 40
        DrawImage(ImageID(Player4),Left,Top,32,32)   
      EndIf
      
    Case 1
      ;Player 1
      If Players(0)\Square > 0 And Players(0)\Active = #True
        Top = Squares(Players(0)\Square)\Offsety + 5
        Left = Squares(Players(0)\Square)\Offsetx + 5
        DrawImage(ImageID(Player1),Left,Top,32,32) 
      EndIf
      
      ;Player 2
      DrawImage(ImageID(Player2),Midx,Midy,32,32)
      
      ;Player 3
      If Players(2)\Square > 0 And Players(2)\Active = #True
        Top = Squares(Players(2)\Square)\Offsety + 40
        Left = Squares(Players(2)\Square)\Offsetx + 5
        DrawImage(ImageID(Player3),Left,Top,32,32) 
      EndIf
      
      ;Player 4
      If Players(3)\Square > 0 And Players(13)\Active = #True
        Top = Squares(Players(3)\Square)\Offsety + 40
        Left = Squares(Players(3)\Square)\Offsetx + 40
        DrawImage(ImageID(Player4),Left,Top,32,32)   
      EndIf      
      
    Case 2
      
      ;Player 1
      If Players(0)\Square > 0 And Players(0)\Active = #True
        Top = Squares(Players(0)\Square)\Offsety + 5
        Left = Squares(Players(0)\Square)\Offsetx + 5
        DrawImage(ImageID(Player1),Left,Top,32,32) 
      EndIf 
      
      ;Player 2
      If Players(1)\Square > 0 And Players(1)\Active = #True
        Top = Squares(Players(1)\Square)\Offsety + 5
        Left = Squares(Players(1)\Square)\Offsetx + 40
        DrawImage(ImageID(Player2),Left,Top,32,32) 
      EndIf     
      
      ;Player 3
      DrawImage(ImageID(Player3),Midx,Midy,32,32)
      
      ;Player 4
      If Players(3)\Square > 0 And Players(3)\Active = #True
        Top = Squares(Players(3)\Square)\Offsety + 40
        Left = Squares(Players(3)\Square)\Offsetx + 40
        DrawImage(ImageID(Player4),Left,Top,32,32)   
      EndIf      
      
    Case 3
      
      ;Player 1
      If Players(0)\Square > 0 And Players(0)\Active = #True
        Top = Squares(Players(0)\Square)\Offsety + 5
        Left = Squares(Players(0)\Square)\Offsetx + 5
        DrawImage(ImageID(Player1),Left,Top,32,32) 
      EndIf
      
      ;Player 2
      If Players(1)\Square > 0 And Players(1)\Active = #True
        Top = Squares(Players(1)\Square)\Offsety + 5
        Left = Squares(Players(1)\Square)\Offsetx + 40
        DrawImage(ImageID(Player2),Left,Top,32,32) 
      EndIf      
      
      ;Player 3
      If Players(2)\Square > 0 And Players(2)\Active = #True
        Top = Squares(Players(2)\Square)\Offsety + 40
        Left = Squares(Players(2)\Square)\Offsetx + 5
        DrawImage(ImageID(Player3),Left,Top,32,32) 
      EndIf     
      
      ;Player 4
      DrawImage(ImageID(Player4),Midx,Midy,32,32)       
      
  EndSelect
 
  StopDrawing()

  If yDone And xDone
    Quit = #True
  EndIf
  
Wend

EndProcedure

Procedure DrawAll()
  
  Define Midx.i,Midy.i,Top.i,Left.i
  
  StartDrawing(CanvasOutput(imgBoard))
  DrawingMode(#PB_2DDrawing_Transparent) 
  DrawImage(ImageID(GameBoard),0,0,GadgetWidth(imgBoard),GadgetHeight(imgBoard)) 
  
  ;Player 1
  If Players(0)\Square > 0 And Players(0)\Active = #True
    Top = Squares(Players(0)\Square)\Offsety + 5
    Left = Squares(Players(0)\Square)\Offsetx + 5
    DrawImage(ImageID(Player1),Left,Top,32,32)    
  EndIf
  
  ;Player 2
  If Players(1)\Square > 0
    Top = Squares(Players(1)\Square)\Offsety + 5
    Left = Squares(Players(1)\Square)\Offsetx + 40
    DrawImage(ImageID(Player2),Left,Top,32,32)  
  EndIf  
  
  ;Player 3
  If Players(2)\Square > 0
    Top = Squares(Players(2)\Square)\Offsety + 40
    Left = Squares(Players(2)\Square)\Offsetx + 5
    DrawImage(ImageID(Player3),Left,Top,32,32) 
  EndIf
  
  ;Player 4
  If Players(3)\Square > 0 
    Top = Squares(Players(3)\Square)\Offsety + 40
    Left = Squares(Players(3)\Square)\Offsetx + 40
    DrawImage(ImageID(Player4),Left,Top,32,32) 
  EndIf

  StopDrawing()
  
EndProcedure

Procedure CDDrawImage(Player.i,StartSquare.i,EndSquare.i,Direct.i)
  
  Define x1.i,y1.i,x2.i,y2.i,j.i
  
  If StartSquare = 0
    StartSquare = 1
  EndIf
  If EndSquare > 29
    EndSquare = 30
  EndIf
  
  If StartSquare > EndSquare
    
    If Direct = #True
      x1 = Squares(Players(Player)\Square)\Offsetx 
      y1 = Squares(Players(Player)\Square)\Offsety 
      x2 = Squares(EndSquare)\Offsetx
      y2 = Squares(EndSquare)\Offsety
      CDMovePlayer(Player,x1,y1,x2,y2)
    Else
      For j = StartSquare To EndSquare Step -1
        x1 = Squares(j)\Offsetx 
        y1 = Squares(j)\Offsety   
        x2 = Squares(j)\Offsetx
        y2 = Squares(j)\Offsety
        CDMovePlayer(Player,x1,y1,x2,y2)
      Next j
    EndIf
    
  Else
    
    If Direct = #True
      x1 = Squares(StartSquare)\Offsetx 
      y1 = Squares(StartSquare)\Offsety 
      x2 = Squares(EndSquare)\Offsetx 
      y2 = Squares(EndSquare)\Offsety 
      CDMovePlayer(Player,x1,y1,x2,y2)
    Else
      x1 = Squares(StartSquare)\Offsetx 
      y1 = Squares(StartSquare)\Offsety 
      For j = StartSquare To EndSquare
        If j > StartSquare
          x1 = Squares(j - 1 )\Offsetx
          y1 = Squares(j - 1)\Offsety 
        EndIf
        x2 = Squares(j)\Offsetx 
        y2 = Squares(j)\Offsety
        CDMovePlayer(Player,x1,y1,x2,y2)
      Next j
    EndIf
    
  EndIf

EndProcedure

Procedure SetSquares()
  
  ;Set Offsets for displaying characters in squares.
  ;x and y are top left corner of each square
  Squares(0)\Offsetx = 5
  Squares(0)\Offsety = 5 
  Squares(1)\Offsetx = 0
  Squares(1)\Offsety = 400 
  Squares(2)\Offsetx = 100
  Squares(2)\Offsety = 400
  Squares(3)\Offsetx = 200
  Squares(3)\Offsety = 400 
  Squares(4)\Offsetx = 300
  Squares(4)\Offsety = 400
  Squares(5)\Offsetx = 400
  Squares(5)\Offsety = 400  
  Squares(6)\Offsetx = 500
  Squares(6)\Offsety = 400
  Squares(7)\Offsetx = 500
  Squares(7)\Offsety = 300
  Squares(8)\Offsetx = 400
  Squares(8)\Offsety = 300 
  Squares(9)\Offsetx = 300
  Squares(9)\Offsety = 300
  Squares(10)\Offsetx = 200
  Squares(10)\Offsety = 300 
  Squares(11)\Offsetx = 100
  Squares(11)\Offsety = 300
  Squares(12)\Offsetx = 0
  Squares(12)\Offsety = 300
  Squares(13)\Offsetx = 0
  Squares(13)\Offsety = 200 
  Squares(14)\Offsetx = 100
  Squares(14)\Offsety = 200  
  Squares(15)\Offsetx = 200
  Squares(15)\Offsety = 200
  Squares(16)\Offsetx = 300
  Squares(16)\Offsety = 200
  Squares(17)\Offsetx = 400
  Squares(17)\Offsety = 200 
  Squares(18)\Offsetx = 500
  Squares(18)\Offsety = 200
  Squares(19)\Offsetx = 500
  Squares(19)\Offsety = 100  
  Squares(20)\Offsetx = 400
  Squares(20)\Offsety = 100
  Squares(21)\Offsetx = 300
  Squares(21)\Offsety = 100
  Squares(22)\Offsetx = 200
  Squares(22)\Offsety = 100 
  Squares(23)\Offsetx = 100
  Squares(23)\Offsety = 100
  Squares(24)\Offsetx = 0 
  Squares(24)\Offsety = 100
  Squares(25)\Offsetx = 0 
  Squares(25)\Offsety = 0 
  Squares(26)\Offsetx = 100 
  Squares(26)\Offsety = 0
  Squares(27)\Offsetx = 200
  Squares(27)\Offsety = 0 
  Squares(28)\Offsetx = 300 
  Squares(28)\Offsety = 0 
  Squares(29)\Offsetx = 400
  Squares(29)\Offsety = 0
  Squares(30)\Offsetx = 500
  Squares(30)\Offsety = 0  
EndProcedure

Procedure ShowPlayers()
  ;Show the Players
  SetGadgetText(strP1Name,Players(0)\Name)
  SetGadgetState(imgP1Disp,ImageID(Player1))
  SetGadgetText(strP2Name,Players(1)\Name)
  SetGadgetState(imgP2Disp,ImageID(Player2))
  SetGadgetText(strP3Name,Players(2)\Name)  
  SetGadgetState(imgP3Disp,ImageID(Player3))
  SetGadgetText(strP4Name,Players(3)\Name)  
  SetGadgetState(imgP4Disp,ImageID(Player4))
  
EndProcedure

Procedure.i RollDice()
  
  Define Event.i,DiceValue.i
  
  Repeat
    
    Event = WindowEvent()

    If event = #PB_Event_Gadget
      If EventGadget() = btnRollDie
        DiceRolling = #False
      EndIf
    EndIf
      
    DiceValue = Random(6,1)

    Select DiceValue
      Case 1
        SetGadgetState(ImgDie, ImageID(Die1))
      Case 2
        SetGadgetState(ImgDie, ImageID(Die2))
      Case 3
        SetGadgetState(ImgDie, ImageID(Die3))
      Case 4
        SetGadgetState(ImgDie, ImageID(Die4))
      Case 5
        SetGadgetState(ImgDie, ImageID(Die5))
      Case 6
        SetGadgetState(ImgDie, ImageID(Die6))

    EndSelect
 
  Until DiceRolling = #False

  ProcedureReturn DiceValue
    
EndProcedure

Procedure ProcessSquare(Player.i)
  
  Define StartSquare.i,EndSquare.i
  
  StartSquare = Players(Player)\Square
  
  Select Players(Player)\Square
    Case 3
      ;Ladder to square 22
      EndSquare = 22
      CDDrawImage(Player,StartSquare,EndSquare,#True)
      Players(CurrentPlayer)\Square = EndSquare 
      ;Players(Player)\Square = 22
    Case 5
      ;Ladder to square 8
      EndSquare = 8
      CDDrawImage(Player,StartSquare,EndSquare,#True)
       Players(CurrentPlayer)\Square = EndSquare
      ;Players(Player)\Square = 8
    Case 11
      ;Ladder to square 26
      EndSquare = 26
      CDDrawImage(Player,StartSquare,EndSquare,#True)
       Players(CurrentPlayer)\Square = EndSquare
      ;Players(Player)\Square = 26  
    Case 17
      ;Snake to square 4
      EndSquare = 4
      CDDrawImage(Player,StartSquare,EndSquare,#True) 
       Players(CurrentPlayer)\Square = EndSquare
      ;Players(Player)\Square = 4    
    Case 19
      ;Snake to square 7
      EndSquare = 7
      CDDrawImage(Player,StartSquare,EndSquare,#True)
       Players(CurrentPlayer)\Square = EndSquare
      ;Players(Player)\Square = 7    
    Case 20
      ;Ladder to square 29
      EndSquare = 29
      CDDrawImage(Player,StartSquare,EndSquare,#True)
       Players(CurrentPlayer)\Square = EndSquare
      ;Players(Player)\Square = 29     
    Case 21
      ;Snake to square 9
      EndSquare = 9
      CDDrawImage(Player,StartSquare,EndSquare,#True)
       Players(CurrentPlayer)\Square = EndSquare
      ;Players(Player)\Square = 9   
    Case 27
      ;Snake to square 1
      EndSquare = 1
      CDDrawImage(Player,StartSquare,EndSquare,#True)
      Players(CurrentPlayer)\Square = EndSquare
      ;Players(Player)\Square = 1
    Case 30
      MessageRequester("Winner",Players(CurrentPlayer)\Name + " Has Won Game Over",#PB_MessageRequester_Ok)
      Playing = #False
  EndSelect

  
EndProcedure

Procedure MovePlayer(Player.i)

  Define Top.i
  Define Left.i
 
  If Players(Player)\Square > 30
    Players(Player)\Square = 30
  EndIf
  
  Select Player
    Case 0
      Top = Squares(Players(Player)\Square)\Offsety + 5
      Left = Squares(Players(Player)\Square)\Offsetx + 5
      ResizeGadget(imgPlayer1, Left, Top, #PB_Ignore , #PB_Ignore )
    Case 1
      Top = Squares(Players(Player)\Square)\Offsety + 5
      Left = Squares(Players(Player)\Square)\Offsetx + 40
      ResizeGadget(imgPlayer2, Left, Top, #PB_Ignore , #PB_Ignore )   
    Case 2
      Top = Squares(Players(Player)\Square)\Offsety + 40
      Left = Squares(Players(Player)\Square)\Offsetx + 5
      ResizeGadget(imgPlayer3, Left, Top, #PB_Ignore , #PB_Ignore )
    Case 3
      Top = Squares(Players(Player)\Square)\Offsety + 40
      Left = Squares(Players(Player)\Square)\Offsetx + 40
      ResizeGadget(imgPlayer4, Left, Top, #PB_Ignore , #PB_Ignore )        
  EndSelect
  
  Delay(100)
   
EndProcedure

Procedure NextPlayer()
  
  Define iLoop.i
  
  For iLoop = 0 To 3
    If Players(iLoop)\Active = #True
      Break
    EndIf
  Next iLoop
  
  If iLoop < 4
  
    CurrentPlayer = CurrentPlayer + 1
    If CurrentPlayer > 3
      CurrentPlayer = 0
    EndIf
    
    While Players(CurrentPlayer)\Active = #False
      CurrentPlayer = CurrentPlayer + 1
      If CurrentPlayer > 3
        CurrentPlayer = 0
      EndIf
    Wend
    
  Else
    
    MessageRequester("Player Information","No Active Player selected. Player 1 only to play?")
    CurrentPlayer = 0
    Players(CurrentPlayer)\Active = #True
    Players(0)\Name = "Player 1"
    SetGadgetState(chkP1,1)
    SetGadgetText(strP1Name,"Player 1")
  EndIf

  SetGadgetText(txtStatus,Players(CurrentPlayer)\Name + "'s turn")
  SetGadgetText(btnRollDie,"Start Roll")
  SetActiveGadget(btnRollDie)
  
EndProcedure

Procedure ResetBoard()
  
  Define iLoop.i,Top.i,Left.i
   
  For iLoop = 0 To 3
    players(iLoop)\Square = 0
  Next iLoop
  StartDrawing(CanvasOutput(imgBoard))
  DrawingMode(#PB_2DDrawing_Transparent) 
  DrawImage(ImageID(GameBoard),0,0,GadgetWidth(imgBoard),GadgetHeight(imgBoard)) 
  StopDrawing()
  currentPlayer = 0
  NextPlayer()    

  SetGadgetText(txtStatus,PlayerS(CurrentPlayer)\Name + "'s turn")
      
  Playing = #True
      
EndProcedure

frmMain = OpenWindow(#PB_Any, 0, 0, 800, 500, "", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
imgBoard = CanvasGadget(#PB_Any, 200, 0, 600, 500)
TextGadget(#PB_Any, 25, 10, 20, 20, "No")
TextGadget(#PB_Any, 50, 10, 70, 20, "Name")
TextGadget(#PB_Any, 140, 10, 40, 20, "Piece")

;Player 1 Details
chkP1 = CheckBoxGadget(#PB_Any, 10, 30, 20, 20, "")
TextGadget(#PB_Any, 25, 35, 10, 20, "1", #PB_Text_Right)
strP1Name = StringGadget(#PB_Any, 50, 30, 80, 20, "")
imgP1Disp = ImageGadget(#PB_Any, 140, 30, 20, 20, 0)

;Player 2 Details
chkP2 = CheckBoxGadget(#PB_Any, 10, 70, 20, 20, "")
TextGadget(#PB_Any, 25, 75, 10, 20, "2", #PB_Text_Right)
strP2Name = StringGadget(#PB_Any, 50, 70, 80, 20, "")
imgP2Disp = ImageGadget(#PB_Any, 140, 70, 20, 20, 0)

;Player 3 Details
chkP3 = CheckBoxGadget(#PB_Any, 10, 110, 20, 20, "")
TextGadget(#PB_Any, 25, 115, 10, 20, "3", #PB_Text_Right)
strP3Name = StringGadget(#PB_Any, 50, 110, 80, 20, "")
imgP3Disp = ImageGadget(#PB_Any, 140, 110, 20, 20, 0)

;Player 4 Details
chkP4 = CheckBoxGadget(#PB_Any, 10, 150, 20, 20, "")
TextGadget(#PB_Any, 25, 155, 10, 20, "4", #PB_Text_Right)
strP4Name = StringGadget(#PB_Any, 50, 150, 80, 20, "")
imgP4Disp = ImageGadget(#PB_Any, 140, 150, 20, 20, 0)

imgDie = ImageGadget(#PB_Any, 50, 210, 50, 40, 0, #PB_Image_Border)
btnRollDie = ButtonGadget(#PB_Any, 10, 260, 130, 20, "Roll Die")
txtStatus = TextGadget(#PB_Any, 10, 180, 130, 20, "Player 1's Turn")
btnNewGame = ButtonGadget(#PB_Any, 10, 350, 130, 20, "New Game")

;Display Game Board
StartDrawing(CanvasOutput(imgBoard))
DrawImage(ImageID(GameBoard),0,0,GadgetWidth(imgBoard),GadgetHeight(imgBoard))        
StopDrawing()

;Show first die image
If LoadImage(0, "Images\dice1.png")    ; change 2nd parameter to the path/filename of your image
  SetGadgetState(ImgDie, ImageID(0))
EndIf

;Setup offsets for squares
SetSquares()
  
;Show player detail
ShowPlayers()
  
ResetBoard()

Define StartSquare.i,EndSquare.i

Repeat
    
  Event = WaitWindowEvent()
      
  Select event
    Case #PB_Event_Gadget
        
      Select EventGadget()
            
        Case btnRollDie
          If Playing = #True
            If  DiceRolling = #False       
   
              DiceRolling = #True
              SetGadgetText(btnRollDie,"Stop Roll")
              StartSquare = Players(CurrentPlayer)\Square
              EndSquare = Players(CurrentPlayer)\Square + RollDice()
              If EndSquare > 29
                EndSquare = 30
              EndIf
              CDDrawImage(CurrentPlayer,StartSquare,EndSquare,#False)
              Players(CurrentPlayer)\Square = EndSquare
              ProcessSquare(CurrentPlayer)             
              DrawAll()
              NextPlayer()
            EndIf
          Else
            
            DiceRolling = #False
            
          EndIf
          
        Case btnNewGame
          
          ResetBoard()
          
        Case strP1Name
          Players(0)\Name = GetGadgetText(strP1Name)
        Case strP2Name
          Players(1)\Name = GetGadgetText(strP2Name)   
        Case strP3Name
          Players(2)\Name = GetGadgetText(strP3Name) 
        Case strP4Name
          Players(3)\Name = GetGadgetText(strP4Name) 
        Case chkP1
          If GetGadgetState(chkP1) = #PB_Checkbox_Checked 
            Players(0)\Active = #True
          Else
            Players(0)\Active = #False
            SetGadgetText(strP1Name,"")            
          EndIf
        Case chkP2
          If GetGadgetState(chkP2) = #PB_Checkbox_Checked 
            Players(1)\Active = #True
          Else
            Players(1)\Active = #False
            SetGadgetText(strP2Name,"")             
          EndIf
        Case chkP3
          If GetGadgetState(chkP3) = #PB_Checkbox_Checked 
            Players(2)\Active = #True
          Else
            Players(2)\Active = #False
            SetGadgetText(strP3Name,"")             
          EndIf
        Case chkP4
          If GetGadgetState(chkP4) = #PB_Checkbox_Checked 
            Players(3)\Active = #True
          Else
            Players(3)\Active = #False
            SetGadgetText(strP4Name,"")              
          EndIf          
          
          
      EndSelect ;EventGadget()
 
  EndSelect ;event
    
Until event = #PB_Event_CloseWindow
; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 709
; FirstLine = 448
; Folding = D9
; EnableUnicode
; EnableXP