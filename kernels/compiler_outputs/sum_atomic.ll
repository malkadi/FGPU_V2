; ModuleID = 'sum_atomic.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @sum_atomic_word(i32* nocapture readonly %in, i32* %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %begin.0 = phi i32 [ %add.i, %entry ], [ %add2, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %sum.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx = getelementptr inbounds i32, i32* %in, i32 %begin.0
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !22
  %add = add nsw i32 %3, %sum.0
  %inc = add nuw nsw i32 %i.0, 1
  %add2 = add i32 %begin.0, %2
  %cmp = icmp eq i32 %inc, %reduce_factor
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %4 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %out, i32 %add.lcssa) #1, !srcloc !26
  ret void
}

; Function Attrs: nounwind
define void @sum_half_atomic(i16* nocapture readonly %in, i16* %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %begin.0 = phi i32 [ %add.i, %entry ], [ %add2, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %sum.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx = getelementptr inbounds i16, i16* %in, i32 %begin.0
  %3 = load i16, i16* %arrayidx, align 2, !tbaa !27
  %conv = sext i16 %3 to i32
  %add = add nsw i32 %conv, %sum.0
  %inc = add nuw nsw i32 %i.0, 1
  %add2 = add i32 %begin.0, %2
  %cmp = icmp eq i32 %inc, %reduce_factor
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %4 = bitcast i16* %out to i32*
  %5 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %4, i32 %add.lcssa) #1, !srcloc !26
  ret void
}

; Function Attrs: nounwind
define void @sum_half_improved_atomic(<2 x i16>* nocapture readonly %in, i16* %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %div = lshr i32 %reduce_factor, 1
  %cmp.18 = icmp eq i32 %div, 0
  br i1 %cmp.18, label %for.end, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %add.i = add nsw i32 %1, %0
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %sum.021 = phi i32 [ 0, %for.body.lr.ph ], [ %add4, %for.body ]
  %i.020 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.body ]
  %begin.019 = phi i32 [ %add.i, %for.body.lr.ph ], [ %add5, %for.body ]
  %arrayidx = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %begin.019
  %3 = load <2 x i16>, <2 x i16>* %arrayidx, align 4
  %4 = extractelement <2 x i16> %3, i32 0
  %conv = sext i16 %4 to i32
  %add = add nsw i32 %conv, %sum.021
  %5 = extractelement <2 x i16> %3, i32 1
  %conv3 = sext i16 %5 to i32
  %add4 = add nsw i32 %add, %conv3
  %add5 = add i32 %begin.019, %2
  %inc = add nuw nsw i32 %i.020, 1
  %exitcond = icmp eq i32 %inc, %div
  br i1 %exitcond, label %for.end.loopexit, label %for.body

for.end.loopexit:                                 ; preds = %for.body
  %add4.lcssa = phi i32 [ %add4, %for.body ]
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %sum.0.lcssa = phi i32 [ 0, %entry ], [ %add4.lcssa, %for.end.loopexit ]
  %6 = bitcast i16* %out to i32*
  %7 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %6, i32 %sum.0.lcssa) #1, !srcloc !26
  ret void
}

; Function Attrs: nounwind
define void @sum_byte_atomic(i8* nocapture readonly %in, i8* %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %begin.0 = phi i32 [ %add.i, %entry ], [ %add2, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %sum.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx = getelementptr inbounds i8, i8* %in, i32 %begin.0
  %3 = load i8, i8* %arrayidx, align 1, !tbaa !29
  %conv = sext i8 %3 to i32
  %add = add nsw i32 %conv, %sum.0
  %inc = add nuw nsw i32 %i.0, 1
  %add2 = add i32 %begin.0, %2
  %cmp = icmp eq i32 %inc, %reduce_factor
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %4 = bitcast i8* %out to i32*
  %5 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %4, i32 %add.lcssa) #1, !srcloc !26
  ret void
}

; Function Attrs: nounwind
define void @sum_byte_improved_atomic(<4 x i8>* nocapture readonly %in, i8* %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %div = lshr i32 %reduce_factor, 2
  %cmp.30 = icmp eq i32 %div, 0
  br i1 %cmp.30, label %for.end, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %add.i = add nsw i32 %1, %0
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %sum.033 = phi i32 [ 0, %for.body.lr.ph ], [ %add10, %for.body ]
  %i.032 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.body ]
  %begin.031 = phi i32 [ %add.i, %for.body.lr.ph ], [ %add11, %for.body ]
  %arrayidx = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %begin.031
  %3 = load <4 x i8>, <4 x i8>* %arrayidx, align 4
  %4 = extractelement <4 x i8> %3, i32 0
  %conv = sext i8 %4 to i32
  %add = add nsw i32 %conv, %sum.033
  %5 = extractelement <4 x i8> %3, i32 1
  %conv3 = sext i8 %5 to i32
  %add4 = add nsw i32 %add, %conv3
  %6 = extractelement <4 x i8> %3, i32 2
  %conv6 = sext i8 %6 to i32
  %add7 = add nsw i32 %add4, %conv6
  %7 = extractelement <4 x i8> %3, i32 3
  %conv9 = sext i8 %7 to i32
  %add10 = add nsw i32 %add7, %conv9
  %add11 = add i32 %begin.031, %2
  %inc = add nuw nsw i32 %i.032, 1
  %exitcond = icmp eq i32 %inc, %div
  br i1 %exitcond, label %for.end.loopexit, label %for.body

for.end.loopexit:                                 ; preds = %for.body
  %add10.lcssa = phi i32 [ %add10, %for.body ]
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %sum.0.lcssa = phi i32 [ 0, %entry ], [ %add10.lcssa, %for.end.loopexit ]
  %8 = bitcast i8* %out to i32*
  %9 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %8, i32 %sum.0.lcssa) #1, !srcloc !26
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15}
!llvm.ident = !{!18}

!0 = !{void (i32*, i32*, i32)* @sum_atomic_word, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (i16*, i16*, i32)* @sum_half_atomic, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"short*", !"short*", !"uint"}
!8 = !{!"kernel_arg_base_type", !"short*", !"short*", !"uint"}
!9 = !{void (<2 x i16>*, i16*, i32)* @sum_half_improved_atomic, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short2*", !"short*", !"uint"}
!11 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short*", !"uint"}
!12 = !{void (i8*, i8*, i32)* @sum_byte_atomic, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"char*", !"char*", !"uint"}
!14 = !{!"kernel_arg_base_type", !"char*", !"char*", !"uint"}
!15 = !{void (<4 x i8>*, i8*, i32)* @sum_byte_improved_atomic, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"char4*", !"char*", !"uint"}
!17 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char*", !"uint"}
!18 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!19 = !{i32 13170}
!20 = !{i32 13310}
!21 = !{i32 12949}
!22 = !{!23, !23, i64 0}
!23 = !{!"int", !24, i64 0}
!24 = !{!"omnipotent char", !25, i64 0}
!25 = !{!"Simple C/C++ TBAA"}
!26 = !{i32 13547}
!27 = !{!28, !28, i64 0}
!28 = !{!"short", !24, i64 0}
!29 = !{!24, !24, i64 0}