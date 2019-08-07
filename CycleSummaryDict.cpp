// Do NOT change. Changes will be lost next time file is generated

#define R__DICTIONARY_FILENAME CycleSummaryDict

/*******************************************************************/
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#define G__DICTIONARY
#include "RConfig.h"
#include "TClass.h"
#include "TDictAttributeMap.h"
#include "TInterpreter.h"
#include "TROOT.h"
#include "TBuffer.h"
#include "TMemberInspector.h"
#include "TInterpreter.h"
#include "TVirtualMutex.h"
#include "TError.h"

#ifndef G__ROOT
#define G__ROOT
#endif

#include "RtypesImp.h"
#include "TIsAProxy.h"
#include "TFileMergeInfo.h"
#include <algorithm>
#include "TCollectionProxyInfo.h"
/*******************************************************************/

#include "TDataMember.h"

// Since CINT ignores the std namespace, we need to do so in this file.
namespace std {} using namespace std;

// Header files passed as explicit arguments
#include "CycleSummary.h"

// Header files passed via #pragma extra_include

namespace ROOT {
   static void *new_CycleSummary(void *p = 0);
   static void *newArray_CycleSummary(Long_t size, void *p);
   static void delete_CycleSummary(void *p);
   static void deleteArray_CycleSummary(void *p);
   static void destruct_CycleSummary(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::CycleSummary*)
   {
      ::CycleSummary *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TInstrumentedIsAProxy< ::CycleSummary >(0);
      static ::ROOT::TGenericClassInfo 
         instance("CycleSummary", ::CycleSummary::Class_Version(), "CycleSummary.h", 13,
                  typeid(::CycleSummary), ::ROOT::Internal::DefineBehavior(ptr, ptr),
                  &::CycleSummary::Dictionary, isa_proxy, 4,
                  sizeof(::CycleSummary) );
      instance.SetNew(&new_CycleSummary);
      instance.SetNewArray(&newArray_CycleSummary);
      instance.SetDelete(&delete_CycleSummary);
      instance.SetDeleteArray(&deleteArray_CycleSummary);
      instance.SetDestructor(&destruct_CycleSummary);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::CycleSummary*)
   {
      return GenerateInitInstanceLocal((::CycleSummary*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::CycleSummary*)0x0); R__UseDummy(_R__UNIQUE_(Init));
} // end of namespace ROOT

//______________________________________________________________________________
atomic_TClass_ptr CycleSummary::fgIsA(0);  // static to hold class pointer

//______________________________________________________________________________
const char *CycleSummary::Class_Name()
{
   return "CycleSummary";
}

//______________________________________________________________________________
const char *CycleSummary::ImplFileName()
{
   return ::ROOT::GenerateInitInstanceLocal((const ::CycleSummary*)0x0)->GetImplFileName();
}

//______________________________________________________________________________
int CycleSummary::ImplFileLine()
{
   return ::ROOT::GenerateInitInstanceLocal((const ::CycleSummary*)0x0)->GetImplFileLine();
}

//______________________________________________________________________________
TClass *CycleSummary::Dictionary()
{
   fgIsA = ::ROOT::GenerateInitInstanceLocal((const ::CycleSummary*)0x0)->GetClass();
   return fgIsA;
}

//______________________________________________________________________________
TClass *CycleSummary::Class()
{
   if (!fgIsA.load()) { R__LOCKGUARD2(gInterpreterMutex); fgIsA = ::ROOT::GenerateInitInstanceLocal((const ::CycleSummary*)0x0)->GetClass(); }
   return fgIsA;
}

//______________________________________________________________________________
void CycleSummary::Streamer(TBuffer &R__b)
{
   // Stream an object of class CycleSummary.

   if (R__b.IsReading()) {
      R__b.ReadClassBuffer(CycleSummary::Class(),this);
   } else {
      R__b.WriteClassBuffer(CycleSummary::Class(),this);
   }
}

namespace ROOT {
   // Wrappers around operator new
   static void *new_CycleSummary(void *p) {
      return  p ? new(p) ::CycleSummary : new ::CycleSummary;
   }
   static void *newArray_CycleSummary(Long_t nElements, void *p) {
      return p ? new(p) ::CycleSummary[nElements] : new ::CycleSummary[nElements];
   }
   // Wrapper around operator delete
   static void delete_CycleSummary(void *p) {
      delete ((::CycleSummary*)p);
   }
   static void deleteArray_CycleSummary(void *p) {
      delete [] ((::CycleSummary*)p);
   }
   static void destruct_CycleSummary(void *p) {
      typedef ::CycleSummary current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::CycleSummary

namespace {
  void TriggerDictionaryInitialization_CycleSummaryDict_Impl() {
    static const char* headers[] = {
"CycleSummary.h",
0
    };
    static const char* includePaths[] = {
"/auto_data/fiber6/apps/jlab_software_20160107/2.0/Linux_SL6.8-x86_64-gcc5.2.0/root/6.08.00/include",
"/auto_data/fiber5/celentano/bdxFlukaFull/",
0
    };
    static const char* fwdDeclCode = R"DICTFWDDCLS(
#line 1 "CycleSummaryDict dictionary forward declarations' payload"
#pragma clang diagnostic ignored "-Wkeyword-compat"
#pragma clang diagnostic ignored "-Wignored-attributes"
#pragma clang diagnostic ignored "-Wreturn-type-c-linkage"
extern int __Cling_Autoloading_Map;
class __attribute__((annotate("$clingAutoload$CycleSummary.h")))  CycleSummary;
)DICTFWDDCLS";
    static const char* payloadCode = R"DICTPAYLOAD(
#line 1 "CycleSummaryDict dictionary payload"

#ifndef G__VECTOR_HAS_CLASS_ITERATOR
  #define G__VECTOR_HAS_CLASS_ITERATOR 1
#endif

#define _BACKWARD_BACKWARD_WARNING_H
#include "CycleSummary.h"

#undef  _BACKWARD_BACKWARD_WARNING_H
)DICTPAYLOAD";
    static const char* classesHeaders[]={
"CycleSummary", payloadCode, "@",
nullptr};

    static bool isInitialized = false;
    if (!isInitialized) {
      TROOT::RegisterModule("CycleSummaryDict",
        headers, includePaths, payloadCode, fwdDeclCode,
        TriggerDictionaryInitialization_CycleSummaryDict_Impl, {}, classesHeaders);
      isInitialized = true;
    }
  }
  static struct DictInit {
    DictInit() {
      TriggerDictionaryInitialization_CycleSummaryDict_Impl();
    }
  } __TheDictionaryInitializer;
}
void TriggerDictionaryInitialization_CycleSummaryDict() {
  TriggerDictionaryInitialization_CycleSummaryDict_Impl();
}
