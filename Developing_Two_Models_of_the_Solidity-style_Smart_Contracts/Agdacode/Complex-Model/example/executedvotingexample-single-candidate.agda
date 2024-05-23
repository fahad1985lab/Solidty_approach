open import constantparameters

module Complex-Model.example.executedvotingexample-single-candidate  where
open import Data.List
open import Data.Bool.Base 
open import Agda.Builtin.Unit
open import Data.Product renaming (_,_ to _,,_ )
open import Data.Maybe hiding (_>>=_)
open import Data.Nat.Base 
open import Data.Nat.Show
open import Data.Fin.Base hiding (_+_; _-_)
import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_ ; refl ; sym ; cong)
open import Agda.Builtin.Nat using (_-_; _*_)
open import Data.String hiding (length; show) renaming (_++_ to _++str_)
open import Data.Unit
open import Data.Empty



--our work
open import  libraries.natCompare
open import Complex-Model.ledgerversion.Ledger-Complex-Model exampleParameters
open import Complex-Model.ccomand.ccommands-cresponse
open import basicDataStructure
open import libraries.Mainlibrary
open import Complex-Model.example.votingexample-single-candidate



IsJust : {A : Set} → Maybe A → Set
IsJust (just _) = ⊤
IsJust nothing  = ⊥


fromJust : {A : Set} → (p : Maybe A) → IsJust p → A
fromJust (just a) tt = a

--------------------------- First test   (adding voter)
-- using function "AddVoter" with (nat 5) on testLedger

resultAfterAddVoter5 : Ledger ×  MsgOrErrorWithGas
resultAfterAddVoter5 = evaluateTerminatingfinal testLedger 1 1 1 "addVoter" (nat 5) 20


resultReturnedAddVoter5 : MsgOrErrorWithGas
resultReturnedAddVoter5 = proj₂ resultAfterAddVoter5
{-
evaluate to
theMsg (nat 5) , 16 gas
so executing addVoter (nat 5) returned (nat 5)
-}
eqproofafterAdd5 : resultReturnedAddVoter5 ≡ theMsg (nat 5) , 16 gas
eqproofafterAdd5 = refl


ledgerAfterAdd5 : Ledger
ledgerAfterAdd5 = proj₁ resultAfterAddVoter5


-- check the pure function with (nat 5) after adding voter to our ledger
checkVoter5afterAdd5 : MsgOrError
checkVoter5afterAdd5 = ledgerAfterAdd5 1 .viewFunction "checkVoter" (nat 5)
{-
evaluate to
theMsg (nat 1)
which means true
-}
eqprooftocheckVoter5 : checkVoter5afterAdd5 ≡ theMsg (nat 1)
eqprooftocheckVoter5 = refl

checkVoter3AfterAdd5 : MsgOrError
checkVoter3AfterAdd5 = ledgerAfterAdd5 1 .viewFunction "checkVoter" (nat 3)
{-
evaluate to
theMsg (nat 0)
which means false
our ledger only includes (nat 5)
-}
eqprooftocheckVoter3 : checkVoter3AfterAdd5 ≡ theMsg (nat 0)
eqprooftocheckVoter3 = refl

----------------------------- Second test   (adding voter)
-- using function "addVoter" with (nat 3) on ledgerAfterAdd5

resultAfterAddVoter3 : Ledger ×  MsgOrErrorWithGas
resultAfterAddVoter3 = evaluateTerminatingfinal ledgerAfterAdd5 1 1 1 "addVoter" (nat 3) 20

resultReturnedAddVoter3 : MsgOrErrorWithGas
resultReturnedAddVoter3 = proj₂ resultAfterAddVoter3

eqproofresultafterAdd3 : resultReturnedAddVoter3 ≡ theMsg (nat 3) , 16 gas
eqproofresultafterAdd3 = refl
{- evaluates to

theMsg (nat 3) , 16 gas

-}


ledgerAfterAdd3 : Ledger
ledgerAfterAdd3 = proj₁ resultAfterAddVoter3

-- check the pure function with (nat 5) after adding voter to our ledger
checkVoter5afterAdd3 : MsgOrError
checkVoter5afterAdd3 = ledgerAfterAdd3 1 .viewFunction "checkVoter" (nat 5)
-- evaluates to
-- theMsg (nat 1) which means true
eqproofcheckVoter5afterAdd3 : checkVoter5afterAdd3 ≡ theMsg (nat 1)
eqproofcheckVoter5afterAdd3 = refl



-- check the pure function with (nat 3) after adding voter to our ledger
checkVoter3afterAdd3 : MsgOrError
checkVoter3afterAdd3 = ledgerAfterAdd3 1 .viewFunction "checkVoter" (nat 3)
-- evaluates to
-- theMsg (nat 1) which means true
eqproofcheckVoter3afterAdd3 : checkVoter3afterAdd3 ≡ theMsg (nat 1)
eqproofcheckVoter3afterAdd3 = refl


-- check the pure function with (nat 2) after adding voter to our ledger
checkVoter2afterAdd3 : MsgOrError
checkVoter2afterAdd3 = ledgerAfterAdd3 1 .viewFunction "checkVoter" (nat 2)
-- evaluates to
-- theMsg (nat 0) which means false because our ledger only include (nat 5) and (nat 3)

--check counter (number of voters)
checkCounterAfterAdd5 : MsgOrError
checkCounterAfterAdd5 = ledgerAfterAdd5 1 .viewFunction "counter" (nat 0)
-- evaluate is
-- theMsg (nat 0)
eqcheckCounterafterAdd5 : checkCounterAfterAdd5 ≡ theMsg (nat 0)
eqcheckCounterafterAdd5 = refl


----------------------------- Third test  using "deletevoter"
-- using function "deleteVoter" with (nat 5) on ledgerAfterAdd3

resultAfterDeleteVoter5 : Ledger ×  MsgOrErrorWithGas
resultAfterDeleteVoter5 = evaluateTerminatingfinal ledgerAfterAdd3 1 1 1 "deleteVoter" (nat 5) 20


resultReturnedDeleteVoter5 : MsgOrErrorWithGas
resultReturnedDeleteVoter5 = proj₂ resultAfterDeleteVoter5
{- evaluates to

theMsg (nat 5) , 16 gas

-}

eqproofresultafterDelete5 : resultReturnedDeleteVoter5 ≡ theMsg (nat 5) , 16 gas
eqproofresultafterDelete5 = refl


ledgerAfterDelete5 : Ledger
ledgerAfterDelete5 = proj₁ resultAfterDeleteVoter5


-- check the pure function with (nat 5) after deleting voter from our ledger
checkVoter5afterDelete5 : MsgOrError
checkVoter5afterDelete5 = ledgerAfterDelete5 1 .viewFunction "checkVoter" (nat 5)
-- evaluates to
-- theMsg (nat 0) which means (nat 5) not in our ledger

eqproofcheck5afterDelete5 : checkVoter5afterDelete5 ≡ theMsg (nat 0)
eqproofcheck5afterDelete5 = refl

-- check the pure function with (nat 3) after deleting voter (nat 5) from our ledger
checkVoter3afterDelete5 : MsgOrError
checkVoter3afterDelete5 = ledgerAfterDelete5 1 .viewFunction "checkVoter" (nat 3)
-- evaluates to
-- theMsg (nat 1) which means our ledger only have (nat 3)

eqproofcheck3afterDelete5 : checkVoter3afterDelete5 ≡ theMsg (nat 1)
eqproofcheck3afterDelete5 = refl



----------------------------- Fourth test  using "addVoter"
-- using function "addVoter" with (nat 8) on ledgerAfterDelete5

resultAfterAddVoter8 : Ledger ×  MsgOrErrorWithGas
resultAfterAddVoter8 = evaluateTerminatingfinal ledgerAfterDelete5 1 1 1 "addVoter" (nat 8) 20

resultReturnedAddVoter8 : MsgOrErrorWithGas
resultReturnedAddVoter8 = proj₂ resultAfterAddVoter8
{- evaluates to

theMsg (nat 8) , 16 gas

-}

eqproofresultAddVoter8 : resultReturnedAddVoter8 ≡ theMsg (nat 8) , 16 gas
eqproofresultAddVoter8 = refl



ledgerAfterAdd8 : Ledger
ledgerAfterAdd8 = proj₁ resultAfterAddVoter8


-- check the pure function with (nat 8) after adding voter to our ledger
checkVoter8afterAdd8 : MsgOrError
checkVoter8afterAdd8 = ledgerAfterAdd8 1 .viewFunction "checkVoter" (nat 8)
-- evaluates to
-- theMsg (nat 1) which means true

eqproofcheck8afterAdd8 : checkVoter8afterAdd8 ≡ theMsg (nat 1)
eqproofcheck8afterAdd8 = refl

-- check the pure function with (nat 3) after adding voter to our ledger
checkVoter3afterAdd8 : MsgOrError
checkVoter3afterAdd8 = ledgerAfterAdd8 1 .viewFunction "checkVoter" (nat 3)
-- evaluates to
-- theMsg (nat 1) which means true

eqproofcheck3afterAdd8 : checkVoter3afterAdd8 ≡ theMsg (nat 1)
eqproofcheck3afterAdd8 = refl


-- check the pure function with (nat 5) after adding voter to our ledger
checkVoter5afterAdd8 : MsgOrError
checkVoter5afterAdd8 = ledgerAfterAdd8 1 .viewFunction "checkVoter" (nat 5)
-- evaluates to
-- theMsg (nat 0) which means false

eqproofcheck5afterAdd8 : checkVoter5afterAdd8 ≡ theMsg (nat 0)
eqproofcheck5afterAdd8 = refl



-- ******** Now our ledger only include (nat 3) and ( nat 8)


checkCounterAfterAdd8 : MsgOrError
checkCounterAfterAdd8 = ledgerAfterAdd8 1 .viewFunction "counter" (nat 0)
-- evaluates to
-- theMsg (nat 0)
-- so the counter is zero


----------------------------- Fifth test  using "vote" (who is not allowed to vote)
-- using function "vote"

resultAfterVote5 : Ledger ×  MsgOrErrorWithGas
resultAfterVote5 = evaluateTerminatingfinal ledgerAfterAdd8 1 5 1 "vote" (nat 0) 50

resultReturnedVote5 : MsgOrErrorWithGas
resultReturnedVote5 = proj₂ resultAfterVote5

eqproofresultReturnedVote5 : resultReturnedVote5 ≡ 
 err (strErr "The voter is not allowed to vote") ⟨ 5 >> 1 ∙ "checkVoter" [ nat 5 ]⟩ , 45 gas
eqproofresultReturnedVote5 = refl
-- returns
-- err (strErr "The voter is not allowed to vote") ⟨ 5 >> 1 ∙ "checkVoter" [ nat 5 ]⟩ , 45 gas
-- because 5 is not allowed to vote

ledgerAfterVote5 : Ledger
ledgerAfterVote5 = proj₁ resultAfterVote5


checkCounterAfterVote5 : MsgOrError
checkCounterAfterVote5 = ledgerAfterVote5  1 .viewFunction "counter" (nat 0)
-- evaluates to
-- theMsg (nat 0)
-- so the counter is still zero

eqproofcheckCounterAfterVote5 : checkCounterAfterVote5 ≡ theMsg (nat 0)
eqproofcheckCounterAfterVote5 = refl

----------------------------- Sixth test  using "vote" (who is allowed to vote)
-- using function "vote"

resultAfterVote3 : Ledger ×  MsgOrErrorWithGas
resultAfterVote3 = evaluateTerminatingfinal ledgerAfterVote5 1 3 1 "vote" (nat 0) 50


resultReturnedVote3 : MsgOrErrorWithGas
resultReturnedVote3 = proj₂ resultAfterVote3
-- evaluates to
-- theMsg (nat 1) , 35 gas

eqproofresultReturnedVote3 : resultReturnedVote3 ≡ theMsg (nat 1) , 35 gas
eqproofresultReturnedVote3 = refl


ledgerAfterVote3 : Ledger
ledgerAfterVote3 = proj₁ resultAfterVote3


-- check the view function with (nat 8) can vote for not
checkVoter3 : MsgOrError
checkVoter3 = ledgerAfterVote3 1 .viewFunction "checkVoter" (nat 3)
-- evaluates to
-- theMsg (nat 0) which means false and can no  longer vote because has voted
eqproofcheckVoter3 : checkVoter3 ≡ theMsg (nat 0)
eqproofcheckVoter3 = refl


-- check the view function with (nat 5) can vote or not
checkVoter5 : MsgOrError
checkVoter5 = ledgerAfterVote3 1 .viewFunction "checkVoter" (nat 5)
-- evaluates to
-- theMsg (nat 0) which means false and cannot vote

-- check the view function with (nat 5) can vote or not
checkVoter8 : MsgOrError
checkVoter8 = ledgerAfterVote3 1 .viewFunction "checkVoter" (nat 8)
-- evaluates to
-- theMsg (nat 1) which means false and cannot vote
eqproofcheckVoter8 : checkVoter8 ≡ theMsg (nat 1)
eqproofcheckVoter8 = refl


checkCounterAfterVote3 : MsgOrError
checkCounterAfterVote3 = ledgerAfterVote3 1 .viewFunction "counter" (nat 0)
-- evaluates to
-- theMsg (nat 1)
-- so the counter is have 1

eqproofcheckCounterAfterVote3 : checkCounterAfterVote3 ≡ theMsg (nat 1)
eqproofcheckCounterAfterVote3 = refl
