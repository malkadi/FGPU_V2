; ModuleID = 'ludecomposition.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind readnone
define float @__divsf3(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = lshr i32 %1, 23
  %3 = and i32 %2, 255
  %4 = bitcast float %b to i32
  %5 = lshr i32 %4, 23
  %6 = and i32 %5, 255
  %7 = xor i32 %4, %1
  %8 = and i32 %7, -2147483648
  %9 = and i32 %1, 8388607
  %10 = and i32 %4, 8388607
  %11 = add nsw i32 %3, -1
  %12 = icmp ugt i32 %11, 253
  %13 = add nsw i32 %6, -1
  %14 = icmp ugt i32 %13, 253
  %or.cond = or i1 %12, %14
  br i1 %or.cond, label %15, label %64

; <label>:15                                      ; preds = %0
  %16 = and i32 %1, 2147483647
  %17 = and i32 %4, 2147483647
  %18 = icmp ugt i32 %16, 2139095040
  br i1 %18, label %19, label %22

; <label>:19                                      ; preds = %15
  %20 = or i32 %1, 4194304
  %21 = bitcast i32 %20 to float
  br label %.thread

; <label>:22                                      ; preds = %15
  %23 = icmp ugt i32 %17, 2139095040
  br i1 %23, label %24, label %27

; <label>:24                                      ; preds = %22
  %25 = or i32 %4, 4194304
  %26 = bitcast i32 %25 to float
  br label %.thread

; <label>:27                                      ; preds = %22
  %28 = icmp eq i32 %16, 2139095040
  %29 = icmp eq i32 %17, 2139095040
  br i1 %28, label %30, label %35

; <label>:30                                      ; preds = %27
  br i1 %29, label %.thread, label %31

; <label>:31                                      ; preds = %30
  %32 = and i32 %4, -2147483648
  %33 = xor i32 %32, %1
  %34 = bitcast i32 %33 to float
  br label %.thread

; <label>:35                                      ; preds = %27
  br i1 %29, label %36, label %38

; <label>:36                                      ; preds = %35
  %37 = bitcast i32 %8 to float
  br label %.thread

; <label>:38                                      ; preds = %35
  %39 = icmp eq i32 %16, 0
  %40 = icmp ne i32 %17, 0
  br i1 %39, label %41, label %43

; <label>:41                                      ; preds = %38
  %42 = bitcast i32 %8 to float
  %. = select i1 %40, float %42, float 0x7FF8000000000000
  ret float %.

; <label>:43                                      ; preds = %38
  br i1 %40, label %47, label %44

; <label>:44                                      ; preds = %43
  %45 = or i32 %8, 2139095040
  %46 = bitcast i32 %45 to float
  br label %.thread

; <label>:47                                      ; preds = %43
  %48 = icmp ult i32 %16, 8388608
  br i1 %48, label %49, label %55

; <label>:49                                      ; preds = %47
  %50 = tail call i32 @llvm.ctlz.i32(i32 %9, i1 false) #3
  %51 = add nuw nsw i32 %50, 24
  %52 = and i32 %51, 31
  %53 = shl i32 %9, %52
  %54 = sub nsw i32 9, %50
  br label %55

; <label>:55                                      ; preds = %49, %47
  %aSignificand.0 = phi i32 [ %53, %49 ], [ %9, %47 ]
  %scale.0 = phi i32 [ %54, %49 ], [ 0, %47 ]
  %56 = icmp ult i32 %17, 8388608
  br i1 %56, label %57, label %64

; <label>:57                                      ; preds = %55
  %58 = tail call i32 @llvm.ctlz.i32(i32 %10, i1 false) #3
  %59 = add nuw nsw i32 %58, 24
  %60 = and i32 %59, 31
  %61 = shl i32 %10, %60
  %62 = add nsw i32 %scale.0, -9
  %63 = add nsw i32 %62, %58
  br label %64

; <label>:64                                      ; preds = %57, %55, %0
  %aSignificand.2 = phi i32 [ %9, %0 ], [ %aSignificand.0, %57 ], [ %aSignificand.0, %55 ]
  %bSignificand.1 = phi i32 [ %10, %0 ], [ %61, %57 ], [ %10, %55 ]
  %scale.3 = phi i32 [ 0, %0 ], [ %63, %57 ], [ %scale.0, %55 ]
  %65 = or i32 %aSignificand.2, 8388608
  %66 = or i32 %bSignificand.1, 8388608
  %67 = sub nsw i32 %3, %6
  %68 = add nsw i32 %67, %scale.3
  %69 = shl i32 %66, 8
  %70 = sub i32 1963258675, %69
  %71 = and i32 %70, 65331
  %72 = and i32 %69, 65280
  %73 = mul nuw i32 %71, %72
  %74 = lshr i32 %70, 16
  %75 = mul nuw i32 %74, %72
  %76 = lshr i32 %66, 8
  %77 = and i32 %76, 65535
  %78 = mul nuw i32 %71, %77
  %79 = mul nuw i32 %74, %77
  %80 = lshr i32 %73, 16
  %81 = and i32 %75, 65280
  %82 = add nuw nsw i32 %80, %81
  %83 = and i32 %78, 65535
  %84 = add nuw nsw i32 %82, %83
  %85 = lshr i32 %84, 16
  %86 = lshr i32 %75, 16
  %87 = lshr i32 %78, 16
  %88 = add i32 %79, %86
  %89 = add i32 %87, %88
  %90 = add i32 %89, %85
  %91 = sub i32 0, %90
  %92 = and i32 %91, 65535
  %93 = mul nuw i32 %92, %71
  %94 = lshr i32 %93, 16
  %95 = mul nuw i32 %92, %74
  %96 = add i32 %94, %95
  %97 = lshr i32 %96, 16
  %98 = and i32 %96, 65535
  %99 = lshr i32 %91, 16
  %100 = mul nuw i32 %99, %71
  %101 = add i32 %98, %100
  %fold.i.5 = add i32 %96, %100
  %102 = shl i32 %fold.i.5, 16
  %103 = lshr i32 %101, 16
  %104 = mul nuw i32 %99, %74
  %105 = add i32 %97, %104
  %106 = add i32 %105, %103
  %107 = zext i32 %102 to i64
  %108 = zext i32 %106 to i64
  %109 = shl nuw i64 %108, 32
  %110 = or i64 %109, %107
  %111 = lshr i64 %110, 31
  %112 = trunc i64 %111 to i32
  %113 = and i32 %112, 65535
  %114 = mul nuw i32 %113, %72
  %115 = lshr i32 %106, 15
  %116 = and i32 %115, 65535
  %117 = mul nuw i32 %116, %72
  %118 = mul nuw i32 %113, %77
  %119 = mul nuw i32 %116, %77
  %120 = lshr i32 %114, 16
  %121 = and i32 %117, 65280
  %122 = add nuw nsw i32 %120, %121
  %123 = and i32 %118, 65535
  %124 = add nuw nsw i32 %122, %123
  %125 = lshr i32 %124, 16
  %126 = lshr i32 %117, 16
  %127 = lshr i32 %118, 16
  %128 = add i32 %119, %126
  %129 = add i32 %128, %127
  %130 = add i32 %129, %125
  %131 = sub i32 0, %130
  %132 = and i32 %131, 65535
  %133 = mul nuw i32 %132, %113
  %134 = lshr i32 %133, 16
  %135 = mul nuw i32 %132, %116
  %136 = add i32 %134, %135
  %137 = lshr i32 %136, 16
  %138 = and i32 %136, 65535
  %139 = lshr i32 %131, 16
  %140 = mul nuw i32 %139, %113
  %141 = add i32 %138, %140
  %fold.i.4 = add i32 %136, %140
  %142 = shl i32 %fold.i.4, 16
  %143 = lshr i32 %141, 16
  %144 = mul nuw i32 %139, %116
  %145 = add i32 %137, %144
  %146 = add i32 %145, %143
  %147 = zext i32 %142 to i64
  %148 = zext i32 %146 to i64
  %149 = shl nuw i64 %148, 32
  %150 = or i64 %149, %147
  %151 = lshr i64 %150, 31
  %152 = trunc i64 %151 to i32
  %153 = and i32 %152, 65535
  %154 = mul nuw i32 %153, %72
  %155 = lshr i32 %146, 15
  %156 = and i32 %155, 65535
  %157 = mul nuw i32 %156, %72
  %158 = mul nuw i32 %153, %77
  %159 = mul nuw i32 %156, %77
  %160 = lshr i32 %154, 16
  %161 = and i32 %157, 65280
  %162 = add nuw nsw i32 %160, %161
  %163 = and i32 %158, 65535
  %164 = add nuw nsw i32 %162, %163
  %165 = lshr i32 %164, 16
  %166 = lshr i32 %157, 16
  %167 = lshr i32 %158, 16
  %168 = add i32 %159, %166
  %169 = add i32 %168, %167
  %170 = add i32 %169, %165
  %171 = sub i32 0, %170
  %172 = and i32 %171, 65535
  %173 = mul nuw i32 %172, %153
  %174 = lshr i32 %173, 16
  %175 = mul nuw i32 %172, %156
  %176 = add i32 %174, %175
  %177 = lshr i32 %176, 16
  %178 = and i32 %176, 65535
  %179 = lshr i32 %171, 16
  %180 = mul nuw i32 %179, %153
  %181 = add i32 %178, %180
  %fold.i = add i32 %176, %180
  %182 = shl i32 %fold.i, 16
  %183 = lshr i32 %181, 16
  %184 = mul nuw i32 %179, %156
  %185 = add i32 %177, %184
  %186 = add i32 %185, %183
  %187 = zext i32 %182 to i64
  %188 = zext i32 %186 to i64
  %189 = shl nuw i64 %188, 32
  %190 = or i64 %189, %187
  %191 = lshr i64 %190, 31
  %192 = trunc i64 %191 to i32
  %193 = add i32 %192, -2
  %194 = shl i32 %aSignificand.2, 1
  %195 = and i32 %193, 65535
  %196 = and i32 %194, 65534
  %197 = mul nuw i32 %195, %196
  %198 = lshr i32 %193, 16
  %199 = mul nuw i32 %198, %196
  %200 = lshr i32 %65, 15
  %201 = and i32 %200, 65535
  %202 = mul nuw i32 %195, %201
  %203 = mul nuw i32 %198, %201
  %204 = lshr i32 %197, 16
  %205 = and i32 %199, 65534
  %206 = add nuw nsw i32 %204, %205
  %207 = and i32 %202, 65535
  %208 = add nuw nsw i32 %206, %207
  %209 = lshr i32 %208, 16
  %210 = lshr i32 %199, 16
  %211 = lshr i32 %202, 16
  %212 = add i32 %210, %203
  %213 = add i32 %212, %211
  %214 = add i32 %213, %209
  %215 = icmp ult i32 %214, 16777216
  %216 = zext i1 %215 to i32
  %.neg6 = sext i1 %215 to i32
  %217 = add i32 %68, %.neg6
  %218 = xor i32 %216, 1
  %219 = lshr i32 %214, %218
  %220 = add nsw i32 %217, 127
  %221 = icmp sgt i32 %220, 254
  br i1 %221, label %222, label %225

; <label>:222                                     ; preds = %64
  %223 = or i32 %8, 2139095040
  %224 = bitcast i32 %223 to float
  br label %.thread

; <label>:225                                     ; preds = %64
  %226 = select i1 %215, i32 24, i32 23
  %227 = shl i32 %65, %226
  %228 = mul i32 %219, %66
  %229 = sub i32 %227, %228
  %230 = icmp slt i32 %220, 1
  %231 = shl i32 %229, 1
  %232 = icmp ugt i32 %231, %66
  br i1 %230, label %233, label %243

; <label>:233                                     ; preds = %225
  %234 = sub i32 -126, %217
  %235 = icmp ult i32 %234, 31
  %236 = select i1 %235, i32 %234, i32 31
  %237 = zext i1 %232 to i32
  %238 = add i32 %237, %219
  %239 = and i32 %236, 31
  %240 = lshr i32 %238, %239
  %241 = or i32 %240, %8
  %242 = bitcast i32 %241 to float
  br label %.thread

; <label>:243                                     ; preds = %225
  %244 = and i32 %219, 8388607
  %245 = shl i32 %220, 23
  %246 = or i32 %244, %245
  %247 = zext i1 %232 to i32
  %248 = add i32 %247, %246
  %249 = or i32 %248, %8
  %250 = bitcast i32 %249 to float
  br label %.thread

.thread:                                          ; preds = %30, %44, %36, %31, %24, %19, %222, %233, %243
  %.2 = phi float [ %224, %222 ], [ %242, %233 ], [ %250, %243 ], [ 0x7FF8000000000000, %30 ], [ %46, %44 ], [ %37, %36 ], [ %34, %31 ], [ %26, %24 ], [ %21, %19 ]
  ret float %.2
}

; Function Attrs: nounwind readnone
define float @__subsf3(float %a, float %b) #0 {
  %1 = bitcast float %b to i32
  %2 = xor i32 %1, -2147483648
  %3 = bitcast i32 %2 to float
  %4 = bitcast float %a to i32
  %5 = and i32 %4, 2147483647
  %6 = and i32 %1, 2147483647
  %7 = add nsw i32 %5, -1
  %8 = icmp ugt i32 %7, 2139095038
  %9 = add nsw i32 %6, -1
  %10 = icmp ugt i32 %9, 2139095038
  %or.cond = or i1 %8, %10
  br i1 %or.cond, label %11, label %30

; <label>:11                                      ; preds = %0
  %12 = icmp ugt i32 %5, 2139095040
  %13 = icmp ugt i32 %6, 2139095040
  %14 = or i1 %12, %13
  %15 = icmp eq i32 %5, 2139095040
  %16 = xor i32 %2, %4
  %17 = icmp eq i32 %16, -2147483648
  %18 = and i1 %15, %17
  %19 = or i1 %14, %18
  %brmerge = or i1 %15, %14
  %.mux = select i1 %19, float 0x7FF8000000000000, float %a
  br i1 %brmerge, label %.thread, label %20

; <label>:20                                      ; preds = %11
  %21 = icmp eq i32 %6, 2139095040
  br i1 %21, label %.thread, label %22

; <label>:22                                      ; preds = %20
  %23 = icmp eq i32 %5, 0
  %24 = icmp ne i32 %6, 0
  br i1 %23, label %25, label %29

; <label>:25                                      ; preds = %22
  br i1 %24, label %.thread, label %26

; <label>:26                                      ; preds = %25
  %27 = and i32 %2, %4
  %28 = bitcast i32 %27 to float
  br label %.thread

; <label>:29                                      ; preds = %22
  br i1 %24, label %30, label %.thread

; <label>:30                                      ; preds = %0, %29
  %31 = icmp ugt i32 %6, %5
  %32 = select i1 %31, i32 %4, i32 %2
  %33 = select i1 %31, i32 %2, i32 %4
  %34 = lshr i32 %33, 23
  %35 = and i32 %34, 255
  %36 = lshr i32 %32, 23
  %37 = and i32 %36, 255
  %38 = and i32 %33, 8388607
  %39 = and i32 %32, 8388607
  %40 = icmp eq i32 %35, 0
  br i1 %40, label %41, label %47

; <label>:41                                      ; preds = %30
  %42 = tail call i32 @llvm.ctlz.i32(i32 %38, i1 false) #3
  %43 = add nuw nsw i32 %42, 24
  %44 = and i32 %43, 31
  %45 = shl i32 %38, %44
  %46 = sub nsw i32 9, %42
  br label %47

; <label>:47                                      ; preds = %41, %30
  %aSignificand.0 = phi i32 [ %45, %41 ], [ %38, %30 ]
  %aExponent.0 = phi i32 [ %46, %41 ], [ %35, %30 ]
  %48 = icmp eq i32 %37, 0
  br i1 %48, label %49, label %55

; <label>:49                                      ; preds = %47
  %50 = tail call i32 @llvm.ctlz.i32(i32 %39, i1 false) #3
  %51 = add nuw nsw i32 %50, 24
  %52 = and i32 %51, 31
  %53 = shl i32 %39, %52
  %54 = sub nsw i32 9, %50
  br label %55

; <label>:55                                      ; preds = %49, %47
  %bSignificand.0 = phi i32 [ %53, %49 ], [ %39, %47 ]
  %bExponent.0 = phi i32 [ %54, %49 ], [ %37, %47 ]
  %56 = and i32 %33, -2147483648
  %57 = xor i32 %33, %32
  %58 = icmp slt i32 %57, 0
  %59 = shl i32 %aSignificand.0, 3
  %60 = or i32 %59, 67108864
  %61 = shl i32 %bSignificand.0, 3
  %62 = or i32 %61, 67108864
  %63 = sub nsw i32 %aExponent.0, %bExponent.0
  %64 = icmp eq i32 %aExponent.0, %bExponent.0
  br i1 %64, label %76, label %65

; <label>:65                                      ; preds = %55
  %66 = icmp ult i32 %63, 32
  br i1 %66, label %67, label %76

; <label>:67                                      ; preds = %65
  %68 = sub nsw i32 0, %63
  %69 = and i32 %68, 31
  %70 = shl i32 %62, %69
  %71 = icmp ne i32 %70, 0
  %72 = and i32 %63, 31
  %73 = lshr i32 %62, %72
  %74 = zext i1 %71 to i32
  %75 = or i32 %74, %73
  br label %76

; <label>:76                                      ; preds = %65, %55, %67
  %bSignificand.1 = phi i32 [ %62, %55 ], [ %75, %67 ], [ 1, %65 ]
  br i1 %58, label %77, label %88

; <label>:77                                      ; preds = %76
  %78 = sub i32 %60, %bSignificand.1
  %79 = icmp eq i32 %60, %bSignificand.1
  br i1 %79, label %.thread, label %80

; <label>:80                                      ; preds = %77
  %81 = icmp ult i32 %78, 67108864
  br i1 %81, label %82, label %97

; <label>:82                                      ; preds = %80
  %83 = tail call i32 @llvm.ctlz.i32(i32 %78, i1 false) #3
  %84 = add nsw i32 %83, -5
  %85 = and i32 %84, 31
  %86 = shl i32 %78, %85
  %87 = sub nsw i32 %aExponent.0, %84
  br label %97

; <label>:88                                      ; preds = %76
  %89 = add i32 %bSignificand.1, %60
  %90 = and i32 %89, 134217728
  %91 = icmp eq i32 %90, 0
  br i1 %91, label %97, label %92

; <label>:92                                      ; preds = %88
  %fold = add i32 %bSignificand.1, %59
  %93 = and i32 %fold, 1
  %94 = lshr i32 %89, 1
  %95 = or i32 %94, %93
  %96 = add nsw i32 %aExponent.0, 1
  br label %97

; <label>:97                                      ; preds = %88, %92, %80, %82
  %aSignificand.1 = phi i32 [ %86, %82 ], [ %78, %80 ], [ %89, %88 ], [ %95, %92 ]
  %aExponent.1 = phi i32 [ %87, %82 ], [ %aExponent.0, %80 ], [ %aExponent.0, %88 ], [ %96, %92 ]
  %98 = icmp sgt i32 %aExponent.1, 254
  br i1 %98, label %99, label %102

; <label>:99                                      ; preds = %97
  %100 = or i32 %56, 2139095040
  %101 = bitcast i32 %100 to float
  br label %.thread

; <label>:102                                     ; preds = %97
  %103 = icmp slt i32 %aExponent.1, 1
  br i1 %103, label %104, label %114

; <label>:104                                     ; preds = %102
  %105 = sub nsw i32 1, %aExponent.1
  %106 = sub nsw i32 0, %105
  %107 = and i32 %106, 31
  %108 = shl i32 %aSignificand.1, %107
  %109 = icmp ne i32 %108, 0
  %110 = and i32 %105, 31
  %111 = lshr i32 %aSignificand.1, %110
  %112 = zext i1 %109 to i32
  %113 = or i32 %112, %111
  br label %114

; <label>:114                                     ; preds = %104, %102
  %aSignificand.2 = phi i32 [ %113, %104 ], [ %aSignificand.1, %102 ]
  %aExponent.2 = phi i32 [ 0, %104 ], [ %aExponent.1, %102 ]
  %115 = and i32 %aSignificand.2, 7
  %116 = lshr i32 %aSignificand.2, 3
  %117 = and i32 %116, 8388607
  %118 = shl i32 %aExponent.2, 23
  %119 = or i32 %118, %56
  %120 = or i32 %119, %117
  %121 = icmp ugt i32 %115, 4
  %122 = zext i1 %121 to i32
  %.6 = add i32 %120, %122
  %123 = icmp eq i32 %115, 4
  %124 = and i32 %.6, 1
  %125 = select i1 %123, i32 %124, i32 0
  %result.1 = add i32 %125, %.6
  %126 = bitcast i32 %result.1 to float
  br label %.thread

.thread:                                          ; preds = %11, %25, %20, %26, %99, %114, %77, %29
  %.2 = phi float [ %a, %29 ], [ %101, %99 ], [ %126, %114 ], [ 0.000000e+00, %77 ], [ %.mux, %11 ], [ %3, %25 ], [ %3, %20 ], [ %28, %26 ]
  ret float %.2
}

; Function Attrs: nounwind readnone
define i64 @__muldsi3(i32 signext %a, i32 signext %b) #0 {
  %1 = and i32 %a, 65535
  %2 = and i32 %b, 65535
  %3 = mul nuw i32 %2, %1
  %4 = lshr i32 %3, 16
  %5 = and i32 %3, 65535
  %6 = lshr i32 %a, 16
  %7 = mul nuw i32 %2, %6
  %8 = add i32 %4, %7
  %9 = lshr i32 %8, 16
  %10 = and i32 %8, 65535
  %11 = lshr i32 %b, 16
  %12 = mul nuw i32 %11, %1
  %13 = add i32 %10, %12
  %fold = add i32 %8, %12
  %14 = shl i32 %fold, 16
  %15 = or i32 %14, %5
  %16 = lshr i32 %13, 16
  %17 = mul nuw i32 %11, %6
  %18 = add i32 %9, %17
  %19 = add i32 %18, %16
  %20 = zext i32 %15 to i64
  %21 = zext i32 %19 to i64
  %22 = shl nuw i64 %21, 32
  %23 = or i64 %22, %20
  ret i64 %23
}

; Function Attrs: nounwind readnone
define i64 @__muldi3(i64 signext %a, i64 signext %b) #0 {
  %1 = lshr i64 %a, 32
  %2 = trunc i64 %1 to i32
  %3 = trunc i64 %a to i32
  %4 = lshr i64 %b, 32
  %5 = trunc i64 %4 to i32
  %6 = trunc i64 %b to i32
  %7 = and i32 %3, 65535
  %8 = and i32 %6, 65535
  %9 = mul nuw i32 %8, %7
  %10 = lshr i32 %9, 16
  %11 = and i32 %9, 65535
  %12 = lshr i32 %3, 16
  %13 = mul nuw i32 %8, %12
  %14 = add i32 %10, %13
  %15 = lshr i32 %14, 16
  %16 = and i32 %14, 65535
  %17 = lshr i32 %6, 16
  %18 = mul nuw i32 %17, %7
  %19 = add i32 %16, %18
  %fold.i = add i32 %14, %18
  %20 = shl i32 %fold.i, 16
  %21 = or i32 %20, %11
  %22 = lshr i32 %19, 16
  %23 = mul nuw i32 %17, %12
  %24 = zext i32 %21 to i64
  %25 = mul i32 %2, %6
  %26 = mul i32 %5, %3
  %27 = add i32 %26, %25
  %28 = add i32 %27, %23
  %29 = add i32 %28, %15
  %30 = add i32 %29, %22
  %31 = zext i32 %30 to i64
  %32 = shl nuw i64 %31, 32
  %33 = or i64 %32, %24
  ret i64 %33
}

; Function Attrs: nounwind readnone
define float @__mulsf3(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = lshr i32 %1, 23
  %3 = and i32 %2, 255
  %4 = bitcast float %b to i32
  %5 = lshr i32 %4, 23
  %6 = and i32 %5, 255
  %7 = xor i32 %4, %1
  %8 = and i32 %7, -2147483648
  %9 = and i32 %1, 8388607
  %10 = and i32 %4, 8388607
  %11 = add nsw i32 %3, -1
  %12 = icmp ugt i32 %11, 253
  %13 = add nsw i32 %6, -1
  %14 = icmp ugt i32 %13, 253
  %or.cond = or i1 %12, %14
  br i1 %or.cond, label %15, label %.thread11

; <label>:15                                      ; preds = %0
  %16 = and i32 %1, 2147483647
  %17 = and i32 %4, 2147483647
  %18 = icmp ugt i32 %16, 2139095040
  %19 = icmp ugt i32 %17, 2139095040
  %20 = or i1 %18, %19
  br i1 %20, label %.thread, label %21

; <label>:21                                      ; preds = %15
  %22 = icmp eq i32 %16, 2139095040
  %23 = icmp eq i32 %17, 2139095040
  %24 = or i1 %22, %23
  br i1 %24, label %25, label %31

; <label>:25                                      ; preds = %21
  %26 = select i1 %22, i32 %17, i32 %16
  %27 = icmp ne i32 %26, 0
  %28 = or i32 %8, 2139095040
  %29 = bitcast i32 %28 to float
  %30 = select i1 %27, float %29, float 0x7FF8000000000000
  br label %.thread

; <label>:31                                      ; preds = %21
  %32 = icmp eq i32 %16, 0
  %33 = icmp eq i32 %17, 0
  %. = or i1 %32, %33
  br i1 %., label %34, label %36

; <label>:34                                      ; preds = %31
  %35 = bitcast i32 %8 to float
  br label %.thread

; <label>:36                                      ; preds = %31
  %37 = icmp ult i32 %16, 8388608
  br i1 %37, label %38, label %44

; <label>:38                                      ; preds = %36
  %39 = tail call i32 @llvm.ctlz.i32(i32 %9, i1 false) #3
  %40 = add nuw nsw i32 %39, 24
  %41 = and i32 %40, 31
  %42 = shl i32 %9, %41
  %43 = sub nsw i32 9, %39
  br label %44

; <label>:44                                      ; preds = %38, %36
  %aSignificand.0 = phi i32 [ %42, %38 ], [ %9, %36 ]
  %scale.0 = phi i32 [ %43, %38 ], [ 0, %36 ]
  %45 = icmp ult i32 %17, 8388608
  br i1 %45, label %46, label %.thread11

; <label>:46                                      ; preds = %44
  %47 = tail call i32 @llvm.ctlz.i32(i32 %10, i1 false) #3
  %48 = add nuw nsw i32 %47, 24
  %49 = and i32 %48, 31
  %50 = shl i32 %10, %49
  %51 = add nsw i32 %scale.0, 9
  %52 = sub nsw i32 %51, %47
  br label %.thread11

.thread11:                                        ; preds = %44, %46, %0
  %aSignificand.2 = phi i32 [ %9, %0 ], [ %aSignificand.0, %46 ], [ %aSignificand.0, %44 ]
  %bSignificand.1 = phi i32 [ %10, %0 ], [ %50, %46 ], [ %10, %44 ]
  %scale.5 = phi i32 [ 0, %0 ], [ %52, %46 ], [ %scale.0, %44 ]
  %53 = or i32 %aSignificand.2, 8388608
  %54 = shl i32 %bSignificand.1, 8
  %55 = or i32 %54, -2147483648
  %56 = zext i32 %53 to i64
  %57 = zext i32 %55 to i64
  %58 = mul nuw i64 %57, %56
  %59 = lshr i64 %58, 32
  %60 = trunc i64 %59 to i32
  %61 = trunc i64 %58 to i32
  %62 = shl nuw nsw i64 %59, 1
  %63 = trunc i64 %62 to i32
  %64 = lshr i32 %61, 31
  %65 = or i32 %63, %64
  %66 = and i32 %60, 8388608
  %67 = icmp ne i32 %66, 0
  %.lobit = lshr exact i32 %66, 23
  %68 = add nsw i32 %3, -127
  %69 = add nsw i32 %68, %6
  %70 = add nsw i32 %69, %scale.5
  %71 = add i32 %70, %.lobit
  %72 = select i1 %67, i32 %60, i32 %65
  %73 = xor i32 %.lobit, 1
  %74 = shl i32 %61, %73
  %75 = icmp slt i32 %71, 1
  br i1 %75, label %76, label %92

; <label>:76                                      ; preds = %.thread11
  %77 = sub i32 1, %71
  %78 = icmp ugt i32 %77, 31
  br i1 %78, label %90, label %.thread13

.thread13:                                        ; preds = %76
  %79 = sub i32 0, %77
  %80 = and i32 %79, 31
  %81 = shl i32 %74, %80
  %82 = icmp ne i32 %81, 0
  %83 = shl i32 %72, %80
  %84 = and i32 %77, 31
  %85 = lshr i32 %74, %84
  %86 = or i32 %83, %85
  %87 = zext i1 %82 to i32
  %88 = or i32 %86, %87
  %89 = lshr i32 %72, %84
  br label %96

; <label>:90                                      ; preds = %76
  %91 = bitcast i32 %8 to float
  br label %.thread

; <label>:92                                      ; preds = %.thread11
  %93 = and i32 %72, 8388607
  %94 = shl i32 %71, 23
  %95 = or i32 %93, %94
  br label %96

; <label>:96                                      ; preds = %.thread13, %92
  %productHi.2 = phi i32 [ %95, %92 ], [ %89, %.thread13 ]
  %productLo.2 = phi i32 [ %74, %92 ], [ %88, %.thread13 ]
  %97 = or i32 %productHi.2, %8
  %98 = icmp ugt i32 %productLo.2, -2147483648
  %99 = zext i1 %98 to i32
  %100 = add i32 %99, %97
  %101 = icmp eq i32 %productLo.2, -2147483648
  %102 = and i32 %100, 1
  %103 = select i1 %101, i32 %102, i32 0
  %104 = add i32 %103, %100
  %105 = icmp sgt i32 %71, 254
  %106 = or i32 %8, 2139095040
  %107 = select i1 %105, i32 %106, i32 %104
  %108 = bitcast i32 %107 to float
  br label %.thread

.thread:                                          ; preds = %15, %34, %25, %96, %90
  %.6 = phi float [ %108, %96 ], [ %91, %90 ], [ 0x7FF8000000000000, %15 ], [ %35, %34 ], [ %30, %25 ]
  ret float %.6
}

; Function Attrs: nounwind
define void @ludecomposition_L_pass(float* nocapture readonly %mat, float* nocapture %L, i32 signext %size, i32 signext %k) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !8
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !9
  %3 = add nsw i32 %2, %1
  %4 = icmp ult i32 %3, %size
  br i1 %4, label %5, label %20

; <label>:5                                       ; preds = %0
  %6 = mul i32 %3, %size
  %7 = add i32 %6, %k
  %8 = getelementptr inbounds float, float* %mat, i32 %7
  %9 = load float, float* %8, align 4, !tbaa !10
  %10 = mul i32 %k, %size
  %11 = add i32 %10, %k
  %12 = getelementptr inbounds float, float* %mat, i32 %11
  %13 = load float, float* %12, align 4, !tbaa !10
  %14 = fdiv float %9, %13, !fpmath !14
  %15 = getelementptr inbounds float, float* %L, i32 %7
  store float %14, float* %15, align 4, !tbaa !10
  %16 = add i32 %k, 1
  %17 = icmp eq i32 %3, %16
  br i1 %17, label %18, label %20

; <label>:18                                      ; preds = %5
  %19 = getelementptr inbounds float, float* %L, i32 %11
  store float 1.000000e+00, float* %19, align 4, !tbaa !10
  br label %20

; <label>:20                                      ; preds = %5, %18, %0
  ret void
}

; Function Attrs: nounwind
define void @ludecomposition_U_pass(float* nocapture %mat, float* nocapture readonly %L, i32 signext %size, i32 signext %k) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !8
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !9
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !8
  %5 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !9
  %6 = add nsw i32 %5, %4
  %7 = mul i32 %3, %size
  %8 = add i32 %7, %k
  %9 = getelementptr inbounds float, float* %L, i32 %8
  %10 = load float, float* %9, align 4, !tbaa !10
  %11 = add i32 %6, %7
  %12 = getelementptr inbounds float, float* %mat, i32 %11
  %13 = load float, float* %12, align 4, !tbaa !10
  %14 = mul i32 %k, %size
  %15 = add i32 %6, %14
  %16 = getelementptr inbounds float, float* %mat, i32 %15
  %17 = load float, float* %16, align 4, !tbaa !10
  %18 = fsub float -0.000000e+00, %10
  %19 = tail call float @llvm.fmuladd.f32(float %18, float %17, float %13)
  store float %19, float* %12, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #2

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!7}

!0 = !{void (float*, float*, i32, i32)* @ludecomposition_L_pass, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{void (float*, float*, i32, i32)* @ludecomposition_U_pass, !1, !2, !3, !4, !5}
!7 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!8 = !{i32 12926}
!9 = !{i32 13066}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !{float 2.500000e+00}
