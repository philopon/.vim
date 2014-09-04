import DynFlags

main :: IO ()
main = mapM_ (\(x,_,_) -> putStrLn x) xFlags
