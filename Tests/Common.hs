{-# LANGUAGE CPP #-}
module Tests.Common where

import System.IO
import Test.QuickCheck
import Network.TLS.Struct (Version(..))
import Network.TLS.Cipher

supportedVersions :: [Version]
supportedVersions = [SSL3, TLS10, TLS11]

supportedCiphers :: [Cipher]
supportedCiphers =
	[ cipher_AES128_SHA1
	, cipher_AES256_SHA1
	, cipher_RC4_128_MD5
	, cipher_RC4_128_SHA1
	]

{- main -}
myQuickCheckArgs = Args
	{ replay     = Nothing
	, maxSuccess = 500
	, maxDiscard = 2000
	, maxSize    = 500
#if MIN_VERSION_QuickCheck(2,3,0)
	, chatty     = True
#endif
	}

run_test n t =
	putStr ("  " ++ n ++ " ... ") >> hFlush stdout >> quickCheckWith myQuickCheckArgs t

liftM6 f m1 m2 m3 m4 m5 m6 = do { x1 <- m1; x2 <- m2; x3 <- m3; x4 <- m4; x5 <- m5; x6 <- m6; return (f x1 x2 x3 x4 x5 x6) }