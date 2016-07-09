module System.Obesity.Control (
  ObesityT,
  ObesityReader,
  ObesityWriter,
  ObesityState
) where



import           Control.Monad.Trans.RWS (RWST)
import           System.Obesity.Types



type ObesityT = RWST ObesityReader ObesityWriter ObesityState IO



type ObesityReader = Options



type ObesityWriter = ()



type ObesityState = ()
