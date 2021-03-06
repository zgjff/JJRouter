//
//  AlertPresentationContext.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import UIKit

final public class AlertPresentationContext {
    /// 转场动画的过渡类型
    ///
    /// - present: present(toView的最终frame)
    /// - dismiss: dismiss(fromView的初始frame)
    public enum TransitionType {
        case present(final: CGRect)
        case dismiss(initial: CGRect)
    }
    
    /// 转场动画持续时间---默认0.2s
    public var duration: TimeInterval = 0.2
    
    /// 空白页点击事件
    public var belowCoverTapped: (() -> ())?
    
    /// preferredContentSize 改变时的动画配置, 默认为nil
    public var preferredContentSizeDidChangeAnimationInfo: (duration: TimeInterval, delay: TimeInterval, options: UIView.AnimationOptions)?
    
    /// 点击弹出界面的其余部分是否可以dismiss,默认是true
    public var touchedCorverDismiss = true
    
    /// 转场动画中presentingViewController的View的frame----默认frame可以使presentingView居中
    public var frameOfPresentedViewInContainerView: ((_ containerViewBounds: CGRect, _ preferredContentSize: CGSize) -> (CGRect))? = Default.centerFrameOfPresentedView
    
    /// presentingViewController的view修饰view----默认4个圆角带阴影view
    public var presentationWrappingView: ((_ presentedViewControllerView: UIView, _ frameOfPresentedView: CGRect) -> UIView)? = Default.shadowAllRoundedCornerWrappingView(10)
    
    /// presentingViewController的view底部封面view,默认是暗灰色view
    ///
    /// 一般是暗灰色的view或者UIVisualEffectView,同时将autoresizingMask设置成[.flexibleWidth, .flexibleHeight];
    ///
    ///  在转场动画时,可以做动画效果
    /// - 例如:UIVisualEffectView可以在presentationTransitionWillBegin动画时间里,将effect从nil,设置成UIBlurEffect(style: .extraLight)
    ///       并在dismissalTransitionWillBegin动画时间里,将effect设置成nil
    /// - 暗灰色的view:可以在presentationTransitionWillBegin动画时间里,将alpha从0.0,设置成0.5
    ///       并在dismissalTransitionWillBegin动画时间里,将alpha设置成0.0
    public var belowCoverView: ((_ frame: CGRect) -> UIView)? = Default.dimmingBelowCoverView
    
    /// 转场动画的具体实现----默认是弹出居中view的动画效果
//    public var transitionAnimator1: ((_ aniView: UIView, _ style: AlertPresentationContext.TransitionType, _ duration: TimeInterval, _ ctx: UIViewControllerContextTransitioning) -> ())? = Default.centerTransitionAnimator
    
    public var transitionAnimator: ((_ fromView: UIView, _ toView: UIView, _ style: AlertPresentationContext.TransitionType, _ duration: TimeInterval, _ ctx: UIViewControllerContextTransitioning) -> ())? = Default.centerTransitionAnimator
    /// 转场动画presentationTransitionWillBegin时,belowCoverView要展示的动画效果,默认是暗灰色view的动画效果
    ///
    /// 例如:
    ///
    ///     context.belowCorverBeginPresentAnimator = { view, coordinator in
    ///          guard let blurView = view as? UIVisualEffectView else { return }
    ///          coordinator.animate(alongsideTransition: { _ in
    ///             blurView.effect = UIBlurEffect(style: .extraLight)
    ///         }, completion: nil)
    ///     }
    ///
    public var willPresentAnimatorForBelowCoverView: ((_ belowCoverView: UIView, _ coordinator: UIViewControllerTransitionCoordinator) -> ())? = Default.dimmingBelowCoverViewAnimator(true)
    
    /// 转场动画dismissalTransitionWillBegin时,belowCoverView要展示的动画效果,默认是高斯模糊view的动画效果
    ///
    /// 例如:
    ///
    ///     context.belowCorverBeginPresentAnimator = { view, coordinator in
    ///          guard let blurView = view as? UIVisualEffectView else { return }
    ///          coordinator.animate(alongsideTransition: { _ in
    ///             blurView.effect = nil
    ///         }, completion: nil)
    ///     }
    ///
    public var willDismissAnimatorForBelowCoverView: ((_ belowCoverView: UIView, _ coordinator: UIViewControllerTransitionCoordinator) -> ())? = Default.dimmingBelowCoverViewAnimator(false)
}

extension AlertPresentationContext {
    /// 使用一套居中弹出动画
    public func usingCenterPresentation() {
        transitionAnimator = Default.centerTransitionAnimator
        frameOfPresentedViewInContainerView = Default.centerFrameOfPresentedView
    }
    
    /// 使用一套从底部弹出动画
    public func usingBottomPresentation() {
        transitionAnimator = Default.bottomTransitionAnimator
        frameOfPresentedViewInContainerView = Default.bottomFrameOfPresentedView
    }
    
    /// 使用一套clear view的显示/隐藏动画
    public func usingClearCoverAnimators() {
        belowCoverView = Default.clearBelowCoverView
        willPresentAnimatorForBelowCoverView = Default.clearBelowCoverViewAnimator(true)
        willDismissAnimatorForBelowCoverView = Default.clearBelowCoverViewAnimator(false)
    }
    
    /// 使用一套暗灰色 view的显示/隐藏动画
    public func usingDimmingBelowCoverAnimators() {
        belowCoverView = Default.dimmingBelowCoverView
        willPresentAnimatorForBelowCoverView = Default.dimmingBelowCoverViewAnimator(true)
        willDismissAnimatorForBelowCoverView = Default.dimmingBelowCoverViewAnimator(false)
    }
    
    /// 使用一套高斯模糊的显示/隐藏动画
    public func usingBlurBelowCoverAnimators() {
        belowCoverView = Default.blurBelowCoverView
        willPresentAnimatorForBelowCoverView = Default.blurBelowCoverViewAnimator(true)
        willDismissAnimatorForBelowCoverView = Default.blurBelowCoverViewAnimator(false)
    }
}
